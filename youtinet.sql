/*
Navicat MySQL Data Transfer

Source Server         : mysql1
Source Server Version : 50051
Source Host           : localhost:3306
Source Database       : youtinet

Target Server Type    : MYSQL
Target Server Version : 50051
File Encoding         : 65001

Date: 2018-11-24 15:58:39
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account
-- ----------------------------
DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
  `account_id` varchar(20) NOT NULL COMMENT '账号',
  `password` varchar(16) NOT NULL COMMENT '密码',
  `privilege` enum('user','admin') NOT NULL default 'user' COMMENT '角色（用户，管理员）',
  `name` varchar(20) default NULL,
  `email` varchar(255) default NULL,
  `phone` varchar(255) default NULL,
  PRIMARY KEY  (`account_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of account
-- ----------------------------
INSERT INTO `account` VALUES ('admin', '123456', 'admin', null, null, null);
INSERT INTO `account` VALUES ('admin2', '123', 'admin', null, null, null);
INSERT INTO `account` VALUES ('admin3', 'test', 'admin', null, null, null);
INSERT INTO `account` VALUES ('admin4', '123456', 'admin', null, null, null);

-- ----------------------------
-- Table structure for demo
-- ----------------------------
DROP TABLE IF EXISTS `demo`;
CREATE TABLE `demo` (
  `id` int(11) NOT NULL,
  `content` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of demo
-- ----------------------------
INSERT INTO `demo` VALUES ('1', 'a');
INSERT INTO `demo` VALUES ('2', 'b');

-- ----------------------------
-- Table structure for knowledge_point
-- ----------------------------
DROP TABLE IF EXISTS `knowledge_point`;
CREATE TABLE `knowledge_point` (
  `knowledge_point_id` int(12) unsigned NOT NULL auto_increment COMMENT '知识点id',
  `subject_id` int(12) unsigned NOT NULL COMMENT '所属学科id',
  `knowledge_point` varchar(255) NOT NULL COMMENT '知识点',
  PRIMARY KEY  (`knowledge_point_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `knowledge_point_ibfk_1` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of knowledge_point
-- ----------------------------

-- ----------------------------
-- Table structure for question
-- ----------------------------
DROP TABLE IF EXISTS `question`;
CREATE TABLE `question` (
  `question_id` int(12) unsigned NOT NULL auto_increment COMMENT '试题id',
  `type_id` int(12) unsigned NOT NULL COMMENT '试题类型id',
  `content` varchar(512) NOT NULL COMMENT '试题内容',
  `answer` varchar(512) NOT NULL COMMENT '试题答案',
  `score` int(2) NOT NULL COMMENT '试题默认分值',
  `difficulty_degree` enum('5','4','3','2','1') NOT NULL COMMENT '难度（1~5）',
  `subject_id` int(12) unsigned NOT NULL COMMENT '所属科目id',
  `knowledge_point_id` int(12) unsigned NOT NULL COMMENT '知识点id',
  PRIMARY KEY  (`question_id`),
  KEY `type_id` (`type_id`),
  KEY `subject_id` (`subject_id`),
  KEY `knowledge_point_id` (`knowledge_point_id`),
  CONSTRAINT `question_ibfk_1` FOREIGN KEY (`type_id`) REFERENCES `question_type` (`question_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `question_ibfk_3` FOREIGN KEY (`knowledge_point_id`) REFERENCES `knowledge_point` (`knowledge_point_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question
-- ----------------------------

-- ----------------------------
-- Table structure for question_type
-- ----------------------------
DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type` (
  `question_type_id` int(12) unsigned NOT NULL auto_increment COMMENT '问题类型id',
  `question_type` varchar(255) NOT NULL COMMENT '问题类型',
  PRIMARY KEY  (`question_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of question_type
-- ----------------------------
INSERT INTO `question_type` VALUES ('1', 'Single_Choice');
INSERT INTO `question_type` VALUES ('2', 'Multiple_Choice');
INSERT INTO `question_type` VALUES ('3', 'Fill_in_the_Blanks');
INSERT INTO `question_type` VALUES ('4', 'Question_and_Answer');

-- ----------------------------
-- Table structure for subject
-- ----------------------------
DROP TABLE IF EXISTS `subject`;
CREATE TABLE `subject` (
  `subject_id` int(12) unsigned NOT NULL auto_increment COMMENT '学科id',
  `subject` varchar(255) NOT NULL COMMENT '学科',
  PRIMARY KEY  (`subject_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of subject
-- ----------------------------

-- ----------------------------
-- Table structure for test_paper
-- ----------------------------
DROP TABLE IF EXISTS `test_paper`;
CREATE TABLE `test_paper` (
  `test_paper_id` int(12) unsigned NOT NULL auto_increment COMMENT '试卷id',
  `creator_id` varchar(20) NOT NULL COMMENT '创建者id',
  `subject_id` int(12) unsigned NOT NULL COMMENT '学科id',
  `title` varchar(255) default NULL COMMENT '试卷标题',
  `total_score` int(4) default NULL COMMENT '总分值',
  `difficulty_degree` enum('5','4','3','2','1') default NULL COMMENT '试卷总体难度(1~5)',
  `semester` int(1) default NULL COMMENT '学期',
  `school_year` varchar(20) default NULL COMMENT '学年（2008-2009）',
  PRIMARY KEY  (`test_paper_id`),
  KEY `creator_id` (`creator_id`),
  KEY `subject_id` (`subject_id`),
  CONSTRAINT `test_paper_ibfk_1` FOREIGN KEY (`creator_id`) REFERENCES `account` (`account_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `test_paper_ibfk_2` FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_paper
-- ----------------------------

-- ----------------------------
-- Table structure for test_paper_contain
-- ----------------------------
DROP TABLE IF EXISTS `test_paper_contain`;
CREATE TABLE `test_paper_contain` (
  `id` int(12) NOT NULL,
  `question_id` int(12) unsigned NOT NULL COMMENT '试题id',
  `test_paper_id` int(12) unsigned NOT NULL COMMENT '试卷id',
  `set_score` int(2) default NULL COMMENT '调整分值，默认null则取问题原本分值',
  `question_number` int(3) NOT NULL COMMENT '大题号',
  `question_number_2` int(3) NOT NULL COMMENT '小题号',
  PRIMARY KEY  (`id`),
  KEY `question_id` (`question_id`),
  KEY `test_paper_id` (`test_paper_id`),
  CONSTRAINT `test_paper_contain_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `question` (`question_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `test_paper_contain_ibfk_2` FOREIGN KEY (`test_paper_id`) REFERENCES `test_paper` (`test_paper_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of test_paper_contain
-- ----------------------------

#
# SQL Export
# Created by Querious (201067)
# Created: July 11, 2020 at 7:13:45 AM GMT+8
# Encoding: Unicode (UTF-8)
#


SET @PREVIOUS_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS `mate_sys_user`;
DROP TABLE IF EXISTS `mate_sys_tenant`;
DROP TABLE IF EXISTS `mate_sys_role_permission`;
DROP TABLE IF EXISTS `mate_sys_role`;
DROP TABLE IF EXISTS `mate_sys_menu`;
DROP TABLE IF EXISTS `mate_sys_dict`;
DROP TABLE IF EXISTS `mate_sys_depart`;
DROP TABLE IF EXISTS `mate_sys_data_source`;
DROP TABLE IF EXISTS `mate_client`;


CREATE TABLE `mate_client` (
  `id` bigint(64) NOT NULL COMMENT '主键',
  `client_id` varchar(48) NOT NULL COMMENT '客户端id',
  `client_secret` varchar(256) NOT NULL COMMENT '客户端密钥',
  `resource_ids` varchar(256) DEFAULT NULL COMMENT '资源集合',
  `scope` varchar(256) NOT NULL COMMENT '授权范围',
  `authorized_grant_types` varchar(256) NOT NULL COMMENT '授权类型',
  `web_server_redirect_uri` varchar(256) DEFAULT NULL COMMENT '回调地址',
  `authorities` varchar(256) DEFAULT NULL COMMENT '权限',
  `access_token_validity` int(11) NOT NULL COMMENT '令牌过期秒数',
  `refresh_token_validity` int(11) NOT NULL COMMENT '刷新令牌过期秒数',
  `additional_information` varchar(4096) DEFAULT NULL COMMENT '附加说明',
  `autoapprove` varchar(256) DEFAULT NULL COMMENT '自动授权',
  `create_user` bigint(64) DEFAULT NULL COMMENT '创建人',
  `create_dept` bigint(64) DEFAULT NULL COMMENT '创建部门',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint(64) DEFAULT NULL COMMENT '修改人',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `status` int(2) NOT NULL COMMENT '状态',
  `is_deleted` int(2) NOT NULL COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='客户端表';


CREATE TABLE `mate_sys_data_source` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `driver_class` varchar(100) DEFAULT NULL COMMENT '驱动类',
  `url` varchar(500) DEFAULT NULL COMMENT '连接地址',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `status` tinyint(1) DEFAULT NULL COMMENT '状态',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源表';


CREATE TABLE `mate_sys_depart` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门ID',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `sort` int(11) NOT NULL DEFAULT '0' COMMENT '排序',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标识',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '上级ID',
  `tenant_id` bigint(20) DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='组织机构表';


CREATE TABLE `mate_sys_dict` (
  `id` bigint(64) NOT NULL COMMENT '主键',
  `parent_id` bigint(64) DEFAULT '0' COMMENT '父主键',
  `code` varchar(255) DEFAULT NULL COMMENT '字典码',
  `dict_key` varchar(255) DEFAULT NULL COMMENT '字典值',
  `dict_value` varchar(255) DEFAULT NULL COMMENT '字典名称',
  `sort` int(11) DEFAULT NULL COMMENT '排序',
  `remark` varchar(255) DEFAULT NULL COMMENT '字典备注',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `is_deleted` int(2) DEFAULT '0' COMMENT '是否已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典表';


CREATE TABLE `mate_sys_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `name` varchar(32) DEFAULT NULL COMMENT '菜单标题',
  `permission` varchar(32) DEFAULT NULL COMMENT '菜单权限',
  `path` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '路径',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父菜单ID',
  `icon` varchar(32) DEFAULT NULL COMMENT '菜单图标',
  `sort` int(11) DEFAULT '1' COMMENT '排序值',
  `keep_alive` char(1) DEFAULT '0' COMMENT '是否缓存该页面: 1:是  0:不是',
  `type` char(1) DEFAULT '0' COMMENT '菜单类型',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '状态',
  `is_deleted` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标识',
  `tenant_id` bigint(20) unsigned DEFAULT '0' COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2023 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';


CREATE TABLE `mate_sys_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_name` varchar(64) DEFAULT NULL COMMENT '角色名称',
  `role_code` varchar(64) DEFAULT NULL COMMENT '角色编码',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标识',
  `tenant_id` int(11) DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_role_code` (`role_code`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';


CREATE TABLE `mate_sys_role_permission` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `menu_id` bigint(64) DEFAULT NULL COMMENT '菜单id',
  `role_id` bigint(64) DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1080 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色权限表';


CREATE TABLE `mate_sys_tenant` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '租户id',
  `name` varchar(255) DEFAULT NULL COMMENT '租户名称',
  `code` varchar(64) DEFAULT NULL COMMENT '租户编码',
  `start_time` timestamp NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` timestamp NULL DEFAULT NULL COMMENT '结束时间',
  `status` char(1) DEFAULT '0' COMMENT '状态',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标识',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='租户表';


CREATE TABLE `mate_sys_user` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `tenant_id` varchar(12) DEFAULT '100000' COMMENT '租户ID',
  `account` varchar(45) DEFAULT NULL COMMENT '账号',
  `password` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '密码',
  `name` varchar(20) DEFAULT NULL COMMENT '昵称',
  `real_name` varchar(10) DEFAULT NULL COMMENT '真名',
  `avatar` varchar(200) DEFAULT NULL COMMENT '头像',
  `email` varchar(45) DEFAULT NULL COMMENT '邮箱',
  `telephone` varchar(45) DEFAULT NULL COMMENT '手机',
  `birthday` datetime DEFAULT NULL COMMENT '生日',
  `sex` smallint(6) DEFAULT NULL COMMENT '性别',
  `role_id` bigint(20) DEFAULT '0' COMMENT '角色id',
  `depart_id` bigint(20) DEFAULT '0' COMMENT '部门id',
  `status` char(1) DEFAULT NULL COMMENT '状态',
  `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
  `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
  `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `is_deleted` char(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';




SET FOREIGN_KEY_CHECKS = @PREVIOUS_FOREIGN_KEY_CHECKS;


SET @PREVIOUS_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;


LOCK TABLES `mate_client` WRITE;
ALTER TABLE `mate_client` DISABLE KEYS;
INSERT INTO `mate_client` (`id`, `client_id`, `client_secret`, `resource_ids`, `scope`, `authorized_grant_types`, `web_server_redirect_uri`, `authorities`, `access_token_validity`, `refresh_token_validity`, `additional_information`, `autoapprove`, `create_user`, `create_dept`, `create_time`, `update_user`, `update_time`, `status`, `is_deleted`) VALUES 
	(1123598811738675202,'mate','mate_secret',NULL,'all','refresh_token,password,authorization_code,captcha','http://localhost:8080',NULL,3600,604800,NULL,NULL,1123598815738675201,1123598813738675201,'2019-03-24 10:42:29',1123598815738675201,'2019-03-24 10:42:32',1,0);
ALTER TABLE `mate_client` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_data_source` WRITE;
ALTER TABLE `mate_sys_data_source` DISABLE KEYS;
INSERT INTO `mate_sys_data_source` (`id`, `name`, `driver_class`, `url`, `username`, `password`, `remark`, `status`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`) VALUES 
	(1,'mysql','com.mysql.cj.jdbc.Driver','jdbc:mysql://localhost:3306/matex?useSSL=false&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&transformedBitIsBoolean=true&serverTimezone=GMT%2B8&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true','root','root','1',0,NULL,NULL,'2020-07-05 03:26:34','2020-07-08 14:02:10',0);
ALTER TABLE `mate_sys_data_source` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_depart` WRITE;
ALTER TABLE `mate_sys_depart` DISABLE KEYS;
INSERT INTO `mate_sys_depart` (`id`, `name`, `sort`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`, `parent_id`, `tenant_id`) VALUES 
	(1,'开发部',0,NULL,NULL,'2020-06-28 07:30:50','2020-07-02 12:49:08','0',-1,0),
	(2,'开发分部',0,NULL,NULL,'2020-06-29 11:14:37',NULL,'0',1,0),
	(3,'开发二部',1,NULL,NULL,'2020-06-29 15:54:27',NULL,'0',1,0),
	(4,'产品部',1,NULL,NULL,'2020-06-29 15:58:54',NULL,'0',-1,0),
	(5,'产品一部',1,NULL,NULL,'2020-06-29 15:59:14',NULL,'0',4,0);
ALTER TABLE `mate_sys_depart` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_dict` WRITE;
ALTER TABLE `mate_sys_dict` DISABLE KEYS;
INSERT INTO `mate_sys_dict` (`id`, `parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`) VALUES 
	(1,0,'status','-1','状态',1,'',NULL,NULL,'2020-07-01 09:59:15','2020-07-01 10:02:00',0),
	(2,1,'status','0','启用',1,NULL,NULL,NULL,'2020-07-01 10:02:23','2020-07-01 10:02:59',0),
	(3,1,'status','1','禁用',2,NULL,NULL,NULL,'2020-07-01 10:02:34','2020-07-01 10:02:59',0);
ALTER TABLE `mate_sys_dict` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_menu` WRITE;
ALTER TABLE `mate_sys_menu` DISABLE KEYS;
INSERT INTO `mate_sys_menu` (`id`, `name`, `permission`, `path`, `parent_id`, `icon`, `sort`, `keep_alive`, `type`, `create_by`, `update_by`, `create_time`, `update_time`, `status`, `is_deleted`, `tenant_id`) VALUES 
	(1000,'系统管理',NULL,'/system',-1,'imac',1,'0','0',NULL,NULL,'2020-06-17 14:21:45','2020-06-24 11:19:19','0','0',0),
	(1100,'用户管理',NULL,'/system/user',1000,'user',1,'0','1',NULL,NULL,'2020-06-18 14:28:36','2020-06-25 11:19:20','0','0',0),
	(1101,'用户新增','sys:user:add','',1100,NULL,1,'0','2',NULL,NULL,'2020-06-17 14:32:51','2020-07-03 08:51:48','0','0',0),
	(1102,'用户修改','sys:user:edit',NULL,1100,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:27:40','2020-07-03 08:51:50','0','0',0),
	(1103,'用户删除','sys:user:delete',NULL,1100,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:27:56','2020-07-03 08:51:52','0','0',0),
	(1104,'用户启用','sys:user:enable',NULL,1100,NULL,1,'0','2',NULL,NULL,'2020-07-03 08:49:47','2020-07-03 08:55:39','0','0',0),
	(1105,'用户禁用','sys:user:disable',NULL,1100,NULL,1,'0','2',NULL,NULL,'2020-07-03 08:50:16','2020-07-03 08:55:40','0','0',0),
	(1106,'用户导出','sys:user:export',NULL,1100,NULL,1,'0','2',NULL,NULL,'2020-07-03 08:50:58','2020-07-03 08:55:42','0','0',0),
	(1200,'角色管理',NULL,'/system/role',1000,'repair',1,'0','1',NULL,NULL,'2020-06-19 16:36:01','2020-06-25 03:19:23','0','0',0),
	(1201,'角色新增','sys:role:add',NULL,1200,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:37:12','2020-07-03 14:00:56','0','0',0),
	(1202,'角色修改','sys:role:edit',NULL,1200,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:38:23','2020-07-03 14:01:06','0','0',0),
	(1203,'角色删除','sys:role:delete',NULL,1200,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:38:53','2020-07-03 14:01:14','0','0',0),
	(1204,'角色导出','sys:role:export',NULL,1200,NULL,1,'0','2',NULL,NULL,'2020-07-03 14:02:37','2020-07-03 14:02:50','0','0',0),
	(1205,'角色权限','sys:role:perm',NULL,1200,NULL,1,'0','2',NULL,NULL,'2020-07-03 14:03:32',NULL,'0','0',0),
	(1300,'菜单管理',NULL,'/system/menu',1000,'tree',1,'0','1',NULL,NULL,'2020-06-19 16:39:07','2020-06-25 03:19:45','0','0',0),
	(1301,'菜单新增','sys:menu:add',NULL,1300,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:39:48','2020-07-03 14:11:59','0','0',0),
	(1302,'菜单修改','sys:menu:edit',NULL,1300,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:40:21','2020-07-03 14:12:15','0','0',0),
	(1303,'菜单删除','sys:menu:delete',NULL,1300,NULL,1,'0','2',NULL,NULL,'2020-06-20 00:40:42','2020-07-03 14:12:23','0','0',0),
	(1304,'菜单启用','sys:menu:enable',NULL,1300,NULL,1,'0','2',NULL,NULL,'2020-07-03 14:12:59','2020-07-03 14:13:14','0','0',0),
	(1305,'菜单禁用','sys:menu:disable',NULL,1300,NULL,1,'0','2',NULL,NULL,'2020-07-03 14:13:34','2020-07-03 14:13:57','0','0',0),
	(1306,'菜单导出','sys:menu:export',NULL,1300,NULL,1,'0','2',NULL,NULL,'2020-07-03 14:14:32',NULL,'0','0',0),
	(1400,'部门管理',NULL,'/system/depart',1000,'table2',1,'0','1',NULL,NULL,'2020-06-26 22:52:41','2020-07-03 14:25:56','0','0',0),
	(1401,'部门新增','sys:depart:add',NULL,1400,NULL,1,'0','2',NULL,NULL,'2020-06-27 14:53:37','2020-07-03 14:26:12','0','0',0),
	(1402,'部门修改','sys:depart:edit',NULL,1400,NULL,1,'0','2',NULL,NULL,'2020-06-27 14:54:47','2020-07-03 14:26:14','0','0',0),
	(1403,'部门删除','sys:depart:delete',NULL,1400,NULL,1,'0','2',NULL,NULL,'2020-06-27 14:55:15','2020-07-03 14:26:17','0','0',0),
	(1404,'部门导出','sys:depart:export',NULL,1400,NULL,1,'0','2',NULL,NULL,'2020-07-03 14:27:26','2020-07-03 14:27:45','0','0',0),
	(2009,'监控管理',NULL,'/monitor',-1,'Galaxee',1,'0','0',NULL,NULL,'2020-06-26 16:00:35',NULL,'0','0',0),
	(2015,'系统运维',NULL,'/devops',-1,'settings',1,'0','0',NULL,NULL,'2020-07-06 03:20:31','2020-07-06 11:20:52','0','0',0),
	(2016,'数据源管理','','/devops/datasource',2015,'table',1,'0','1',NULL,NULL,'2020-07-06 19:21:58','2020-07-09 06:50:01','0','0',0),
	(2017,'数据源新增','sys:datasource:add',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:08:11',NULL,'0','0',0),
	(2018,'数据源修改','sys:datasource:edit',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:08:40',NULL,'0','0',0),
	(2019,'数据源删除','sys:datasource:delete',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:09:05',NULL,'0','0',0),
	(2020,'数据源导出','sys:datasource:export',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:09:25',NULL,'0','0',0),
	(2021,'代码生成',NULL,'/devops/generator',2015,'download',1,'0','1',NULL,NULL,'2020-07-09 07:08:50',NULL,'0','0',0),
	(2022,'代码生成','dev:gen',NULL,2021,NULL,1,'0','2',NULL,NULL,'2020-07-09 07:09:45',NULL,'0','0',0);
ALTER TABLE `mate_sys_menu` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_role` WRITE;
ALTER TABLE `mate_sys_role` DISABLE KEYS;
INSERT INTO `mate_sys_role` (`id`, `role_name`, `role_code`, `description`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`, `tenant_id`) VALUES 
	(1,'管理员','admin','管理员组',NULL,NULL,'2020-06-28 15:02:16',NULL,'0',NULL),
	(2,'演示会员','demo2','演示会员组',NULL,NULL,'2020-06-28 07:02:36','2020-06-28 07:02:58','0',NULL);
ALTER TABLE `mate_sys_role` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_role_permission` WRITE;
ALTER TABLE `mate_sys_role_permission` DISABLE KEYS;
INSERT INTO `mate_sys_role_permission` (`id`, `menu_id`, `role_id`) VALUES 
	(977,1000,2),
	(978,1300,2),
	(979,1301,2),
	(980,1302,2),
	(981,1303,2),
	(982,2009,2),
	(1046,1000,1),
	(1047,1100,1),
	(1048,1101,1),
	(1049,1102,1),
	(1050,1103,1),
	(1051,1104,1),
	(1052,1105,1),
	(1053,1106,1),
	(1054,1200,1),
	(1055,1201,1),
	(1056,1202,1),
	(1057,1203,1),
	(1058,1204,1),
	(1059,1205,1),
	(1060,1300,1),
	(1061,1301,1),
	(1062,1302,1),
	(1063,1303,1),
	(1064,1304,1),
	(1065,1305,1),
	(1066,1306,1),
	(1067,1400,1),
	(1068,1401,1),
	(1069,1402,1),
	(1070,1403,1),
	(1071,1404,1),
	(1072,2015,1),
	(1073,2016,1),
	(1074,2017,1),
	(1075,2018,1),
	(1076,2019,1),
	(1077,2020,1),
	(1078,2021,1),
	(1079,2022,1);
ALTER TABLE `mate_sys_role_permission` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_tenant` WRITE;
ALTER TABLE `mate_sys_tenant` DISABLE KEYS;
ALTER TABLE `mate_sys_tenant` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_user` WRITE;
ALTER TABLE `mate_sys_user` DISABLE KEYS;
INSERT INTO `mate_sys_user` (`id`, `tenant_id`, `account`, `password`, `name`, `real_name`, `avatar`, `email`, `telephone`, `birthday`, `sex`, `role_id`, `depart_id`, `status`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`) VALUES 
	(2,'100000','admin','{bcrypt}$2a$10$jddK.xwTn99XM9ggy64Zgu.eBK2GBiyk9RmtQEjg99S2F8otQ8ieq','admin','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'0',NULL,NULL,'2020-07-02 15:29:12','2020-07-04 10:23:13','0'),
	(3,'100000','admin2','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin2','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,2,4,'0',NULL,NULL,'2020-06-16 20:05:43','2020-07-02 05:38:59','0'),
	(4,'100000','admin4','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin4','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,2,1,'0',NULL,NULL,'2020-06-17 04:05:43','2020-07-02 05:39:00','0'),
	(5,'100000','admin5','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin5','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'0',NULL,NULL,'2020-06-17 12:05:43','2020-07-02 13:39:01','0'),
	(6,'100000','admin6','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'0',NULL,NULL,'2020-06-17 12:05:43','2020-07-02 13:39:01','0'),
	(7,'100000','admin7','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'0',NULL,NULL,'2020-06-16 12:05:43','2020-06-30 12:55:52','0'),
	(8,'100000','admin8','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,2,1,'0',NULL,NULL,'2020-06-17 04:05:43','2020-07-02 05:39:03','0'),
	(9,'100000','admin9','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'1',NULL,NULL,'2020-06-17 04:05:43','2020-07-02 05:39:03','0'),
	(10,'100000','admin10','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'1',NULL,NULL,'2020-06-16 12:05:43','2020-07-02 13:39:04','0'),
	(20,'100000','pp','{bcrypt}$2a$10$Yg737tR5BkroA0dJs8H2JureZhMPT3InoSJqGkjhvZ9JvqrUM.yR.','pp',NULL,NULL,NULL,NULL,'2020-06-29 16:00:00',0,1,1,'1',NULL,NULL,'2020-07-03 09:41:45','2020-07-07 19:41:34','0'),
	(22,'100000','pp1','{bcrypt}$2a$10$jddK.xwTn99XM9ggy64Zgu.eBK2GBiyk9RmtQEjg99S2F8otQ8ieq','pp1',NULL,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg',NULL,'1899','2020-06-29 00:00:00',0,2,1,'0',NULL,NULL,'2020-07-02 17:57:13','2020-07-03 03:06:46','0');
ALTER TABLE `mate_sys_user` ENABLE KEYS;
UNLOCK TABLES;




SET FOREIGN_KEY_CHECKS = @PREVIOUS_FOREIGN_KEY_CHECKS;



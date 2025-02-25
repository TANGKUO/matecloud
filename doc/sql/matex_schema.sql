#
# SQL Export
# Created by Querious (201067)
# Created: August 31, 2020 at 10:30:55 PM GMT+8
# Encoding: Unicode (UTF-8)
#


SET @PREVIOUS_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;


DROP TABLE IF EXISTS `mate_sys_user`;
DROP TABLE IF EXISTS `mate_sys_tenant`;
DROP TABLE IF EXISTS `mate_sys_role_permission`;
DROP TABLE IF EXISTS `mate_sys_role`;
DROP TABLE IF EXISTS `mate_sys_menu`;
DROP TABLE IF EXISTS `mate_sys_log`;
DROP TABLE IF EXISTS `mate_sys_dict`;
DROP TABLE IF EXISTS `mate_sys_depart`;
DROP TABLE IF EXISTS `mate_sys_data_source`;
DROP TABLE IF EXISTS `mate_sys_config`;
DROP TABLE IF EXISTS `mate_sys_client`;
DROP TABLE IF EXISTS `mate_sys_blacklist`;
DROP TABLE IF EXISTS `mate_sys_attachment`;


CREATE TABLE `mate_sys_attachment` (
                                       `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '附件ID',
                                       `storage_id` bigint(20) NOT NULL DEFAULT '0' COMMENT '存储ID',
                                       `attachment_group_id` int(11) NOT NULL DEFAULT '0' COMMENT '组ID',
                                       `name` varchar(128) NOT NULL COMMENT '文件名称',
                                       `size` int(11) NOT NULL COMMENT '文件大小',
                                       `url` varchar(2080) NOT NULL COMMENT '文件地址',
                                       `file_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '上传文件名',
                                       `thumb_url` varchar(2080) NOT NULL DEFAULT '' COMMENT '缩略图地址',
                                       `type` tinyint(2) NOT NULL COMMENT '类型',
                                       `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
                                       `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                       `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                       `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                                       `is_deleted` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标识',
                                       `is_recycle` tinyint(1) NOT NULL DEFAULT '0' COMMENT '是否加入回收站 0.否|1.是',
                                       PRIMARY KEY (`id`),
                                       KEY `type` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='附件表';


CREATE TABLE `mate_sys_blacklist` (
                                      `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                      `ip` varchar(20) DEFAULT NULL COMMENT 'IP地址',
                                      `request_uri` varchar(100) DEFAULT NULL COMMENT '请求地址',
                                      `request_method` varchar(10) DEFAULT NULL COMMENT '请求方法',
                                      `start_time` varchar(32) DEFAULT NULL COMMENT '开始时间',
                                      `end_time` varchar(32) DEFAULT NULL COMMENT '结束时间',
                                      `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '状态：0:关闭 1:开启',
                                      `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
                                      `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                      `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                      `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                      PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统黑名单表';


CREATE TABLE `mate_sys_client` (
                                   `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
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
                                   `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
                                   `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                   `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                   `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '0' COMMENT '状态',
                                   `is_deleted` int(2) NOT NULL DEFAULT '0' COMMENT '是否已删除',
                                   PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='客户端表';


CREATE TABLE `mate_sys_config` (
                                   `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                   `parent_id` bigint(64) DEFAULT '0' COMMENT '父主键',
                                   `code` varchar(255) DEFAULT NULL COMMENT '码',
                                   `c_key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '值',
                                   `value` varchar(255) DEFAULT NULL COMMENT '名称',
                                   `sort` int(11) DEFAULT NULL COMMENT '排序',
                                   `remark` varchar(255) DEFAULT NULL COMMENT '备注',
                                   `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
                                   `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                   `create_time` datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                   `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
                                   `tenant_id` int(11) DEFAULT '1',
                                   `is_deleted` int(2) DEFAULT '0' COMMENT '是否已删除',
                                   PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='配置表';


CREATE TABLE `mate_sys_data_source` (
                                        `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增id',
                                        `name` varchar(100) DEFAULT NULL COMMENT '名称',
                                        `db_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '数据库类型',
                                        `driver_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '驱动类型',
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='数据源表';


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
                                 `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
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
                                 PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='字典表';


CREATE TABLE `mate_sys_log` (
                                `id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '主键id',
                                `type` char(1) DEFAULT '1' COMMENT '日志类型',
                                `trace_id` varchar(64) DEFAULT NULL COMMENT '跟踪ID',
                                `title` varchar(64) DEFAULT NULL COMMENT '日志标题',
                                `operation` text COMMENT '操作内容',
                                `method` varchar(64) DEFAULT NULL COMMENT '执行方法',
                                `params` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '参数',
                                `url` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '请求路径',
                                `ip` varchar(64) DEFAULT NULL COMMENT 'ip地址',
                                `execute_time` bigint(20) DEFAULT '0' COMMENT '耗时',
                                `location` varchar(64) DEFAULT NULL COMMENT '地区',
                                `exception` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
                                `create_by` varchar(32) DEFAULT NULL COMMENT '创建人',
                                `update_by` varchar(32) DEFAULT NULL COMMENT '更新人',
                                `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
                                `update_time` datetime DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
                                `is_deleted` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0' COMMENT '删除标识',
                                `tenant_id` int(11) DEFAULT NULL COMMENT '租户ID',
                                PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统日志表';


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
) ENGINE=InnoDB AUTO_INCREMENT=2052 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='菜单权限表';


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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';


CREATE TABLE `mate_sys_role_permission` (
                                            `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '主键',
                                            `menu_id` bigint(64) DEFAULT NULL COMMENT '菜单id',
                                            `role_id` bigint(64) DEFAULT NULL COMMENT '角色id',
                                            PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2103 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色权限表';


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


LOCK TABLES `mate_sys_attachment` WRITE;
ALTER TABLE `mate_sys_attachment` DISABLE KEYS;
INSERT INTO `mate_sys_attachment` (`id`, `storage_id`, `attachment_group_id`, `name`, `size`, `url`, `file_name`, `thumb_url`, `type`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`, `is_recycle`) VALUES
(13,0,0,'timg (3).jpeg',26516,'https://cdn.ckjia.com/10e258da699b4c318ff59e24f2599420.jpeg','10e258da699b4c318ff59e24f2599420.jpeg','',1,NULL,NULL,'2020-08-10 03:29:26',NULL,'0',0),
(16,0,0,'background.jpg',261548,'https://cdn.ckjia.com/3b8f8e2b5ffb43b0905397b82a6b3ec6.jpg','3b8f8e2b5ffb43b0905397b82a6b3ec6.jpg','',1,NULL,NULL,'2020-08-10 11:55:53',NULL,'0',0),
(17,0,0,'nav-icon-new.active.png',3036,'https://cdn.ckjia.com/5efe50fcd0e744eaa7a2e7c6d851dd82.png','5efe50fcd0e744eaa7a2e7c6d851dd82.png','',1,NULL,NULL,'2020-08-10 13:39:06',NULL,'0',0),
(18,0,0,'nav-icon-user.active.png',2150,'https://cdn.ckjia.com/90cef6a278b34c1690af938193e2d813.png','90cef6a278b34c1690af938193e2d813.png','',1,NULL,NULL,'2020-08-10 13:40:56',NULL,'0',0),
(19,0,0,'nav-icon-cat.active.png',3338,'https://cdn.ckjia.com/8ffa2bf6e6e7491b8460bf308abd30de.png','8ffa2bf6e6e7491b8460bf308abd30de.png','',1,NULL,NULL,'2020-08-10 13:41:49',NULL,'0',0),
(20,0,0,'nav-icon-index.active.png',2754,'https://cdn.ckjia.com/478acfc9aeb140a4b79c6402ba3bd021.png','478acfc9aeb140a4b79c6402ba3bd021.png','',1,NULL,NULL,'2020-08-10 13:54:53',NULL,'0',0),
(21,0,0,'baiduzhifu2x.png',19415,'https://cdn.ckjia.com/5ba794ec8d054ce995d37d364c5a9836.png','5ba794ec8d054ce995d37d364c5a9836.png','',1,NULL,NULL,'2020-08-10 13:56:10',NULL,'0',0),
(22,0,0,'h_seckill.png',6008,'https://cdn.ckjia.com/897d70b0635f48999baa635d6debbbee.png','897d70b0635f48999baa635d6debbbee.png','',1,NULL,NULL,'2020-08-10 13:59:47',NULL,'0',0),
(24,0,0,'mate-bg2.jpeg',79028,'https://cdn.ckjia.com/7667a4086d3c40948207dc8e02b52ff9.jpeg','7667a4086d3c40948207dc8e02b52ff9.jpeg','',1,NULL,NULL,'2020-08-11 14:19:53',NULL,'0',0);
ALTER TABLE `mate_sys_attachment` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_blacklist` WRITE;
ALTER TABLE `mate_sys_blacklist` DISABLE KEYS;
INSERT INTO `mate_sys_blacklist` (`id`, `ip`, `request_uri`, `request_method`, `start_time`, `end_time`, `status`, `create_by`, `update_by`, `create_time`, `update_time`) VALUES
(1,NULL,'/**/actuator/**','ALL',NULL,NULL,'0',NULL,NULL,'2020-08-23 03:40:16','2020-08-23 03:40:34');
ALTER TABLE `mate_sys_blacklist` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_client` WRITE;
ALTER TABLE `mate_sys_client` DISABLE KEYS;
INSERT INTO `mate_sys_client` (`id`, `client_id`, `client_secret`, `resource_ids`, `scope`, `authorized_grant_types`, `web_server_redirect_uri`, `authorities`, `access_token_validity`, `refresh_token_validity`, `additional_information`, `autoapprove`, `create_by`, `update_by`, `create_time`, `update_time`, `status`, `is_deleted`) VALUES
(1,'mate','mate_secret',NULL,'all','refresh_token,password,authorization_code,captcha,sms,social','http://localhost:10001',NULL,3600,3600,NULL,NULL,NULL,NULL,'2020-07-12 14:49:23','2020-07-28 04:22:54','0',0);
ALTER TABLE `mate_sys_client` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_config` WRITE;
ALTER TABLE `mate_sys_config` DISABLE KEYS;
INSERT INTO `mate_sys_config` (`id`, `parent_id`, `code`, `c_key`, `value`, `sort`, `remark`, `create_by`, `update_by`, `create_time`, `update_time`, `tenant_id`, `is_deleted`) VALUES
(1,0,'oss','default','qiniuoss',0,'默认OSS配置',NULL,NULL,'2020-08-08 01:44:31','2020-08-10 01:38:58',1,0),
(2,1,'alioss','endpoint','oss-cn-beijing.aliyuncs.com',1,'对象存储服务的URL',NULL,NULL,'2020-08-08 01:46:10','2020-08-09 16:14:15',1,0),
(3,1,'alioss','customDomain','mall-zaitong.oss-cn-beijing.aliyuncs.com',2,'自定义域名',NULL,NULL,'2020-08-08 01:46:32','2020-08-09 16:14:08',1,0),
(4,1,'alioss','pathStyleAccess','false',3,'pathStyleAccess',NULL,NULL,'2020-08-08 01:47:21','2020-08-08 01:47:35',1,0),
(5,1,'alioss','accessKey','LTA******rzjrV',4,'Access Key',NULL,NULL,'2020-08-08 01:47:40','2020-08-09 07:53:48',1,0),
(6,1,'alioss','secretKey','9H6Bxg**************bfNoy4E',5,'Access Secret',NULL,NULL,'2020-08-08 01:53:13','2020-08-10 01:31:53',1,0),
(7,1,'alioss','bucketName','m********g',6,'空间名',NULL,NULL,'2020-08-08 01:53:14','2020-08-09 16:13:15',1,0),
(8,1,'qiniuoss','endpoint','s3-cn-south-1.qiniucs.com',1,'对象存储服务的URL',NULL,NULL,'2020-08-08 01:46:10','2020-08-10 01:33:31',1,0),
(9,1,'qiniuoss','customDomain','cd**********com',2,'自定义域名',NULL,NULL,'2020-08-08 01:46:32','2020-08-10 01:33:31',1,0),
(10,1,'qiniuoss','pathStyleAccess','false',3,'pathStyleAccess',NULL,NULL,'2020-08-08 01:47:21','2020-08-08 01:47:35',1,0),
(11,1,'qiniuoss','accessKey','pj2M-4k_*********************dQpjb1L',4,'Access Key',NULL,NULL,'2020-08-08 01:47:40','2020-08-10 01:33:31',1,0),
(12,1,'qiniuoss','secretKey','Dx17O-dbR*******************Mxlc4bb',5,'Access Secret',NULL,NULL,'2020-08-08 01:53:13','2020-08-10 01:33:31',1,0),
(13,1,'qiniuoss','bucketName','ckjia',6,'空间名',NULL,NULL,'2020-08-08 01:53:14','2020-08-10 01:33:31',1,0),
(14,1,'miniooss','endpoint','66666',1,'对象存储服务的URL',NULL,NULL,'2020-08-08 01:46:10','2020-08-09 02:03:52',1,0),
(15,1,'miniooss','customDomain','2222',2,'自定义域名',NULL,NULL,'2020-08-08 01:46:32','2020-08-08 16:55:54',1,0),
(16,1,'miniooss','pathStyleAccess','false',3,'pathStyleAccess',NULL,NULL,'2020-08-08 01:47:21','2020-08-08 01:47:35',1,0),
(17,1,'miniooss','accessKey','3333',4,'Access Key',NULL,NULL,'2020-08-08 01:47:40','2020-08-08 16:55:58',1,0),
(18,1,'miniooss','secretKey','4444',5,'Access Secret',NULL,NULL,'2020-08-08 01:53:13','2020-08-08 16:56:02',1,0),
(19,1,'miniooss','bucketName','5555',6,'空间名',NULL,NULL,'2020-08-08 01:53:14','2020-08-08 16:56:06',1,0);
ALTER TABLE `mate_sys_config` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_data_source` WRITE;
ALTER TABLE `mate_sys_data_source` DISABLE KEYS;
INSERT INTO `mate_sys_data_source` (`id`, `name`, `db_type`, `driver_class`, `url`, `username`, `password`, `remark`, `status`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`) VALUES
(1,'mysql','mysql','com.mysql.cj.jdbc.Driver','jdbc:mysql://localhost:3306/matex?useSSL=false&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&transformedBitIsBoolean=true&serverTimezone=GMT%2B8&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true','root','root','1',0,NULL,NULL,'2020-07-04 19:26:34','2020-07-11 00:44:59',0),
(10,'mysql_mdc','mysql','com.mysql.cj.jdbc.Driver','jdbc:mysql://localhost:3306/pangu_mdx?useSSL=false&useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&transformedBitIsBoolean=true&serverTimezone=GMT%2B8&nullCatalogMeansCurrent=true&allowPublicKeyRetrieval=true','root','root',NULL,NULL,NULL,NULL,'2020-07-20 02:46:55',NULL,0);
ALTER TABLE `mate_sys_data_source` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_depart` WRITE;
ALTER TABLE `mate_sys_depart` DISABLE KEYS;
INSERT INTO `mate_sys_depart` (`id`, `name`, `sort`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`, `parent_id`, `tenant_id`) VALUES
(1,'开发部',0,NULL,NULL,'2020-06-27 15:30:50','2020-07-01 20:49:08','0',-1,0),
(2,'开发分部',0,NULL,NULL,'2020-06-29 11:14:37',NULL,'0',1,0),
(3,'开发二部',1,NULL,NULL,'2020-06-29 15:54:27',NULL,'0',1,0),
(4,'产品部',1,NULL,NULL,'2020-06-29 07:58:54','2020-08-17 06:53:59','0',-1,0),
(5,'产品一部',1,NULL,NULL,'2020-06-29 15:59:14',NULL,'0',4,0);
ALTER TABLE `mate_sys_depart` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_dict` WRITE;
ALTER TABLE `mate_sys_dict` DISABLE KEYS;
INSERT INTO `mate_sys_dict` (`id`, `parent_id`, `code`, `dict_key`, `dict_value`, `sort`, `remark`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`) VALUES
(1,0,'status','-1','状态',1,'',NULL,NULL,'2020-07-01 09:59:15','2020-07-01 10:02:00',0),
(2,1,'status','0','启用',1,NULL,NULL,NULL,'2020-07-01 10:02:23','2020-07-01 10:02:59',0),
(3,1,'status','1','禁用',2,NULL,NULL,NULL,'2020-07-01 10:02:34','2020-07-01 10:02:59',0),
(4,0,'dbtype','-1','数据库类型',1,NULL,NULL,NULL,'2020-07-11 08:47:02',NULL,0),
(5,4,'dbtype','mysql','com.mysql.cj.jdbc.Driver',1,NULL,NULL,NULL,'2020-07-11 08:47:44','2020-07-11 08:53:11',0),
(6,4,'dbtype','oracle','oracle.jdbc.OracleDriver',2,NULL,NULL,NULL,'2020-07-11 08:48:00','2020-07-11 08:54:05',0),
(7,4,'dbtype','oracle12c','oracle.jdbc.OracleDriver',3,NULL,NULL,NULL,'2020-07-11 08:49:10','2020-07-11 08:54:12',0),
(24,0,'ok','-1','确认',NULL,NULL,NULL,NULL,'2020-07-19 13:31:16','2020-07-19 21:31:28',0),
(25,24,'ok','yes','是',NULL,NULL,NULL,NULL,'2020-07-19 21:31:40','2020-07-20 05:32:12',0),
(26,24,'ok','no','否',NULL,NULL,NULL,NULL,'2020-07-20 05:32:06',NULL,0);
ALTER TABLE `mate_sys_dict` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_log` WRITE;
ALTER TABLE `mate_sys_log` DISABLE KEYS;
ALTER TABLE `mate_sys_log` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_menu` WRITE;
ALTER TABLE `mate_sys_menu` DISABLE KEYS;
INSERT INTO `mate_sys_menu` (`id`, `name`, `permission`, `path`, `parent_id`, `icon`, `sort`, `keep_alive`, `type`, `create_by`, `update_by`, `create_time`, `update_time`, `status`, `is_deleted`, `tenant_id`) VALUES
(1000,'系统管理',NULL,'/system',-1,'imac',1,'0','0',NULL,NULL,'2020-06-17 14:21:45','2020-08-11 03:41:11','0','0',0),
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
(2015,'开发运维',NULL,'/devops',-1,'settings',2,'0','0',NULL,NULL,'2020-07-05 11:20:31','2020-08-11 03:42:05','0','0',0),
(2016,'数据源管理','','/devops/datasource',2015,'table',1,'0','1',NULL,NULL,'2020-07-06 19:21:58','2020-07-09 06:50:01','0','0',0),
(2017,'数据源新增','sys:datasource:add',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:08:11',NULL,'0','0',0),
(2018,'数据源修改','sys:datasource:edit',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:08:40',NULL,'0','0',0),
(2019,'数据源删除','sys:datasource:delete',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:09:05',NULL,'0','0',0),
(2020,'数据源导出','sys:datasource:export',NULL,2016,NULL,1,'0','2',NULL,NULL,'2020-07-07 04:09:25',NULL,'0','0',0),
(2021,'代码生成',NULL,'/devops/generator',2015,'download',1,'0','1',NULL,NULL,'2020-07-09 07:08:50',NULL,'0','0',0),
(2022,'代码生成','devops:gen',NULL,2021,NULL,1,'0','2',NULL,NULL,'2020-07-08 23:09:45','2020-07-13 14:35:14','0','0',0),
(2023,'监控配置中心',NULL,'/devops/monitor',2015,'validCode',1,'0','1',NULL,NULL,'2020-07-10 20:23:07','2020-07-11 04:39:40','0','0',0),
(2026,'客户端管理',NULL,'/system/client',1000,'iPhone',1,'0','1',NULL,NULL,'2020-07-13 22:47:20',NULL,'0','0',0),
(2027,'新增客户端','sys:client:add',NULL,2026,NULL,1,'0','2',NULL,NULL,'2020-07-13 22:47:44',NULL,'0','0',0),
(2028,'修改客户端','sys:client:edit',NULL,2026,NULL,1,'0','2',NULL,NULL,'2020-07-13 23:47:37',NULL,'0','0',0),
(2029,'删除客户端','sys:client:delete',NULL,2026,NULL,1,'0','2',NULL,NULL,'2020-07-13 23:48:11',NULL,'0','0',0),
(2030,'导出客户端','sys:client:export',NULL,2026,NULL,1,'0','2',NULL,NULL,'2020-07-13 23:48:28',NULL,'0','0',0),
(2031,'启禁客户端','sys:client:status',NULL,2026,NULL,1,'0','2',NULL,NULL,'2020-07-13 23:49:22',NULL,'0','0',0),
(2032,'操作日志',NULL,'/system/log',1000,'comment',2,'0','1',NULL,NULL,'2020-07-15 05:11:09','2020-08-11 03:41:43','0','0',0),
(2033,'详细日志','sys:log:detail',NULL,2032,NULL,1,'0','2',NULL,NULL,'2020-07-16 04:05:48',NULL,'0','0',0),
(2034,'日志删除','sys:log:delete',NULL,2032,NULL,1,'0','2',NULL,NULL,'2020-07-16 04:06:16',NULL,'0','0',0),
(2035,'字典管理',NULL,'/system/dict',1000,'add',1,'0','1',NULL,NULL,'2020-07-17 09:29:31',NULL,'0','0',0),
(2036,'新增字典','sys:dict:add',NULL,2035,NULL,1,'0','2',NULL,NULL,'2020-07-20 02:48:01',NULL,'0','0',0),
(2037,'修改字典','sys:dict:edit',NULL,2035,NULL,1,'0','2',NULL,NULL,'2020-07-20 02:48:20',NULL,'0','0',0),
(2038,'删除字典','sys:dict:delete',NULL,2035,NULL,1,'0','2',NULL,NULL,'2020-07-20 02:48:39',NULL,'0','0',0),
(2039,'组件管理',NULL,'/system/component',1000,'nested',1,'0','1',NULL,NULL,'2020-08-08 05:35:05',NULL,'0','0',0),
(2040,'内容管理',NULL,'/content',-1,'content',4,'0','0',NULL,NULL,'2020-08-09 00:21:42','2020-08-29 03:12:22','0','0',0),
(2041,'文件管理',NULL,'/content/attachment',2040,'folder',1,'0','1',NULL,NULL,'2020-08-09 00:27:06','2020-08-10 03:31:49','0','0',0),
(2042,'修改组件','sys:comp:edit',NULL,2039,NULL,1,'0','2',NULL,NULL,'2020-08-10 00:42:28','2020-08-10 08:42:57','0','0',0),
(2043,'上传文件','sys:attach:add',NULL,2041,NULL,1,'0','2',NULL,NULL,'2020-08-10 08:43:52',NULL,'0','0',0),
(2044,'删除文件','sys:attach:delete',NULL,2041,NULL,1,'0','2',NULL,NULL,'2020-08-10 08:44:29',NULL,'0','0',0),
(2045,'网关中心',NULL,'/gateway',-1,'gateway',3,'0','0',NULL,NULL,'2020-08-28 19:12:00','2020-08-28 19:12:16','0','0',0),
(2047,'黑名单管理',NULL,'/gateway/blacklist',2045,'blacklist',1,'0','1',NULL,NULL,'2020-08-29 03:15:34',NULL,'0','0',0),
(2048,'新增黑名单','gw:bl:add',NULL,2047,NULL,1,'0','2',NULL,NULL,'2020-08-29 09:38:52',NULL,'0','0',0),
(2049,'修改黑名单','gw:bl:edit',NULL,2047,NULL,1,'0','2',NULL,NULL,'2020-08-29 09:39:27',NULL,'0','0',0),
(2050,'删除黑名单','gw:bl:del',NULL,2047,NULL,1,'0','2',NULL,NULL,'2020-08-29 09:39:51',NULL,'0','0',0),
(2051,'黑名单状态','gw:bl:status',NULL,2047,NULL,1,'0','2',NULL,NULL,'2020-08-29 09:44:20',NULL,'0','0',0);
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
(2043,1000,1),
(2044,2035,1),
(2045,2036,1),
(2046,2037,1),
(2047,2038,1),
(2048,2026,1),
(2049,2027,1),
(2050,2028,1),
(2051,2029,1),
(2052,2030,1),
(2053,2031,1),
(2054,2039,1),
(2055,2042,1),
(2056,1300,1),
(2057,1301,1),
(2058,1302,1),
(2059,1303,1),
(2060,1304,1),
(2061,1305,1),
(2062,1306,1),
(2063,1100,1),
(2064,1101,1),
(2065,1102,1),
(2066,1103,1),
(2067,1104,1),
(2068,1105,1),
(2069,1106,1),
(2070,1200,1),
(2071,1201,1),
(2072,1202,1),
(2073,1203,1),
(2074,1204,1),
(2075,1205,1),
(2076,1400,1),
(2077,1401,1),
(2078,1402,1),
(2079,1403,1),
(2080,1404,1),
(2081,2032,1),
(2082,2033,1),
(2083,2034,1),
(2084,2015,1),
(2085,2021,1),
(2086,2022,1),
(2087,2023,1),
(2088,2016,1),
(2089,2018,1),
(2090,2020,1),
(2091,2019,1),
(2092,2017,1),
(2093,2045,1),
(2094,2047,1),
(2095,2048,1),
(2096,2049,1),
(2097,2050,1),
(2098,2051,1),
(2099,2040,1),
(2100,2041,1),
(2101,2043,1),
(2102,2044,1);
ALTER TABLE `mate_sys_role_permission` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_tenant` WRITE;
ALTER TABLE `mate_sys_tenant` DISABLE KEYS;
ALTER TABLE `mate_sys_tenant` ENABLE KEYS;
UNLOCK TABLES;


LOCK TABLES `mate_sys_user` WRITE;
ALTER TABLE `mate_sys_user` DISABLE KEYS;
INSERT INTO `mate_sys_user` (`id`, `tenant_id`, `account`, `password`, `name`, `real_name`, `avatar`, `email`, `telephone`, `birthday`, `sex`, `role_id`, `depart_id`, `status`, `create_by`, `update_by`, `create_time`, `update_time`, `is_deleted`) VALUES
(2,'100000','admin','{bcrypt}$2a$10$IhNoDpkdJ1VzbnfX1pH35.S25n2tHaxU4hSltf7An.wdiXAsYe2Jm','admin','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18810001000',NULL,1,1,1,'0',NULL,NULL,'2020-07-02 07:29:12','2020-08-09 17:29:15','0'),
(3,'100000','admin2','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin2','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,2,4,'0',NULL,NULL,'2020-06-16 20:05:43','2020-07-02 05:38:59','0'),
(4,'100000','admin4','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin4','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,2,1,'0',NULL,NULL,'2020-06-17 04:05:43','2020-07-02 05:39:00','0'),
(5,'100000','admin5','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin5','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'0',NULL,NULL,'2020-06-17 04:05:43','2020-07-02 05:39:01','0'),
(6,'100000','admin6','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'0',NULL,NULL,'2020-06-17 12:05:43','2020-07-02 13:39:01','0'),
(7,'100000','admin7','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'0',NULL,NULL,'2020-06-16 12:05:43','2020-06-30 12:55:52','0'),
(8,'100000','admin8','{bcrypt}$2a$10$6YPJ0dkaqh9x3zwTfidRBeT0U5vJ7Si7wXFx9Gc/K3pMxz8J18TrW','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,2,1,'0',NULL,NULL,'2020-06-16 20:05:43','2020-07-15 04:31:24','0'),
(9,'100000','admin9','{bcrypt}$2a$10$pDzXQpiSIl74Jekj9CxMWOPbEV9MHkjkZ7GXX/RomtIyXz8m6Ruia','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'1',NULL,NULL,'2020-06-16 20:05:43','2020-07-01 21:39:03','0'),
(10,'100000','admin10','{bcrypt}$2a$10$A5cfRbFDCsOg.1UTlWyEZu8DJHSr9GnANXQMsRSIDAtZHuiQicr0K','admin6','mate','https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg','mate@mate.vip','18910001000',NULL,1,1,1,'1',NULL,NULL,'2020-06-15 12:05:43','2020-07-15 03:58:00','0'),
(22,'100000','pp1','{bcrypt}$2a$10$jddK.xwTn99XM9ggy64Zgu.eBK2GBiyk9RmtQEjg99S2F8otQ8ieq','pp1',NULL,'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2084118128,2518711034&fm=26&gp=0.jpg',NULL,'1899','2020-06-26 16:00:00',0,2,1,'0',NULL,NULL,'2020-06-30 09:57:13','2020-06-30 19:06:46','0');
ALTER TABLE `mate_sys_user` ENABLE KEYS;
UNLOCK TABLES;




SET FOREIGN_KEY_CHECKS = @PREVIOUS_FOREIGN_KEY_CHECKS;



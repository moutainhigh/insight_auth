
-- ----------------------------
-- Table structure for ibs_application
-- ----------------------------
DROP TABLE IF EXISTS `ibs_application`;
CREATE TABLE `ibs_application` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `index` int(11) unsigned NOT NULL COMMENT '序号',
  `name` varchar(64) NOT NULL COMMENT '应用名称',
  `alias` varchar(64) NOT NULL COMMENT '应用简称',
  `icon` varchar(128) DEFAULT NULL COMMENT '应用图标',
  `domain` varchar(128) DEFAULT NULL COMMENT '应用域名',
  `permit_life` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '授权码生命周期(毫秒)',
  `token_life` int(10) unsigned NOT NULL DEFAULT '7200000' COMMENT '令牌生命周期(毫秒)',
  `is_signin_one` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否单点登录:0.允许多点;1.单点登录',
  `is_auto_refresh` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否自动刷新:0.手动刷新;1.自动刷新',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建用户ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_application_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_application_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='应用表';

-- ----------------------------
-- Table structure for ibs_navigator
-- ----------------------------
DROP TABLE IF EXISTS `ibs_navigator`;
CREATE TABLE `ibs_navigator` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `parent_id` char(32) DEFAULT NULL COMMENT '父级导航ID',
  `app_id` char(32) NOT NULL COMMENT '应用ID',
  `type` tinyint(3) unsigned NOT NULL COMMENT '导航级别',
  `index` int(11) unsigned NOT NULL COMMENT '序号',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `module_info` json DEFAULT NULL COMMENT '模块信息',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建用户ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_navigator_app_id` (`app_id`) USING BTREE,
  KEY `idx_navigator_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_navigator_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_navigator_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci COMMENT='导航表';

-- ----------------------------
-- Table structure for ibs_function
-- ----------------------------
DROP TABLE IF EXISTS `ibs_function`;
CREATE TABLE `ibs_function` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `nav_id` char(32) NOT NULL COMMENT '导航(末级模块)ID',
  `type` tinyint(3) unsigned NOT NULL COMMENT '功能类型 0:全局功能;1:数据项功能;2:其他功能',
  `index` int(11) unsigned NOT NULL COMMENT '序号',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `auth_codes` varchar(256) DEFAULT NULL COMMENT '接口授权码,多个授权码使用英文逗号分隔',
  `func_info` json DEFAULT NULL COMMENT '图标信息',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建用户ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_function_nav_id` (`nav_id`) USING BTREE,
  KEY `idx_function_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_function_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci COMMENT='功能表';


-- ----------------------------
-- Table structure for ibu_user
-- ----------------------------
DROP TABLE IF EXISTS `ibu_user`;
CREATE TABLE `ibu_user` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `code` varchar(16) DEFAULT NULL COMMENT '用户编码',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `account` varchar(64) NOT NULL COMMENT '登录账号',
  `mobile` varchar(32) DEFAULT NULL COMMENT '手机号',
  `email` varchar(64) DEFAULT NULL COMMENT '电子邮箱',
  `union_id` varchar(128) DEFAULT NULL COMMENT '微信UnionID',
  `open_id` json DEFAULT NULL COMMENT '微信OpenID',
  `password` varchar(256) NOT NULL DEFAULT 'e10adc3949ba59abbe56e057f20f883e' COMMENT '密码(RSA加密)',
  `pay_password` char(32) DEFAULT NULL COMMENT '支付密码(MD5)',
  `head_img` varchar(256) DEFAULT NULL COMMENT '用户头像',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `is_builtin` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否内置:0.非内置;1.内置',
  `is_invalid` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否失效:0.有效;1.失效',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建人ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_user_code` (`code`) USING BTREE,
  UNIQUE KEY `idx_user_account` (`account`) USING BTREE,
  UNIQUE KEY `idx_user_mobile` (`mobile`) USING BTREE,
  UNIQUE KEY `idx_user_email` (`email`) USING BTREE,
  UNIQUE KEY `idx_user_union_id` (`union_id`) USING BTREE,
  KEY `idx_user_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_user_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='用户表';


-- ----------------------------
-- Table structure for ibt_tenant
-- ----------------------------
DROP TABLE IF EXISTS `ibt_tenant`;
CREATE TABLE `ibt_tenant` (
  `id` char(32) NOT NULL COMMENT 'UUID主键',
  `code` char(8) NOT NULL COMMENT '租户编号',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `alias` varchar(8) DEFAULT NULL COMMENT '别名',
  `company_info` json DEFAULT NULL COMMENT '企业信息',
  `remark` varchar(1024) DEFAULT NULL COMMENT '描述',
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '租户状态:0.待审核;1.已通过;2.未通过',
  `is_invalid` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否失效:0.正常;1.失效',
  `auditor` varchar(64) DEFAULT NULL COMMENT '审核人',
  `auditor_id` char(32) DEFAULT NULL COMMENT '审核人ID',
  `audited_time` datetime NULL DEFAULT NULL COMMENT '审核时间',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建人ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_code` (`code`) USING BTREE,
  KEY `idx_tenant_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_tenant_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='租户表';

-- ----------------------------
-- Table structure for ibt_tenant_app
-- ----------------------------
DROP TABLE IF EXISTS `ibt_tenant_app`;
CREATE TABLE `ibt_tenant_app` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `tenant_id` char(32) NOT NULL COMMENT '租户ID',
  `app_id` char(32) NOT NULL COMMENT '应用ID',
  `expire_date` date DEFAULT NULL COMMENT '过期日期',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_app_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_tenant_app_app_id` (`app_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='租户-应用关系表';

-- ----------------------------
-- Table structure for ibt_tenant_user
-- ----------------------------
DROP TABLE IF EXISTS `ibt_tenant_user`;
CREATE TABLE `ibt_tenant_user` (
  `id` char(32) NOT NULL COMMENT 'UUID主键',
  `tenant_id` char(32) NOT NULL COMMENT '租户ID',
  `user_id` char(32) NOT NULL COMMENT '应用ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_tenant_user_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_tenant_user_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='租户-用户关系表';


-- ----------------------------
-- Table structure for ibu_group
-- ----------------------------
DROP TABLE IF EXISTS `ibu_group`;
CREATE TABLE `ibu_group` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `tenant_id` char(32) NOT NULL COMMENT '租户ID',
  `code` char(4) NOT NULL COMMENT '用户组编码',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `is_builtin` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否内置:0.非内置;1.内置',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建人ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_group_code` (`code`) USING BTREE,
  KEY `idx_group_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_group_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='用户组表';

-- ----------------------------
-- Table structure for ibu_group_member
-- ----------------------------
DROP TABLE IF EXISTS `ibu_group_member`;
CREATE TABLE `ibu_group_member` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `group_id` char(32) NOT NULL COMMENT '用户组ID',
  `user_id` char(32) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_group_member_group_id` (`group_id`) USING BTREE,
  KEY `idx_group_member_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='用户组成员表';


-- ----------------------------
-- Table structure for ibo_organize
-- ----------------------------
DROP TABLE IF EXISTS `ibo_organize`;
CREATE TABLE `ibo_organize` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `tenant_id` char(32) NOT NULL COMMENT '租户ID',
  `parent_id` char(32) DEFAULT NULL COMMENT '父级ID',
  `type` tinyint(3) unsigned DEFAULT NULL COMMENT '节点类型:0.机构;1.部门;2.职位',
  `index` tinyint(3) unsigned NOT NULL COMMENT '序号',
  `code` varchar(8) DEFAULT NULL COMMENT '编码',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `alias` varchar(64) DEFAULT NULL COMMENT '简称',
  `full_name` varchar(128) DEFAULT NULL COMMENT '全称',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `is_invalid` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否失效:0.有效;1.失效',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建人ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_organize_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_organize_parent_id` (`parent_id`) USING BTREE,
  KEY `idx_organize_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_organize_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='组织机构表';

-- ----------------------------
-- Table structure for ibo_organize_member
-- ----------------------------
DROP TABLE IF EXISTS `ibo_organize_member`;
CREATE TABLE `ibo_organize_member` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `post_id` char(32) NOT NULL COMMENT '职位ID(组织机构表ID)',
  `user_id` char(32) NOT NULL COMMENT '用户ID(用户表ID)',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_organize_member_post_id` (`post_id`) USING BTREE,
  KEY `idx_organize_member_user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='职位成员表';


-- ----------------------------
-- Table structure for ibr_role
-- ----------------------------
DROP TABLE IF EXISTS `ibr_role`;
CREATE TABLE `ibr_role` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `tenant_id` char(32) DEFAULT NULL COMMENT '租户ID,如为空且非内置则为角色模板',
  `app_id` char(32) NOT NULL COMMENT '应用ID',
  `name` varchar(64) NOT NULL COMMENT '名称',
  `remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `is_builtin` bit(1) NOT NULL DEFAULT b'0' COMMENT '是否内置:0.非内置;1.内置',
  `creator` varchar(64) NOT NULL COMMENT '创建人',
  `creator_id` char(32) NOT NULL COMMENT '创建人ID',
  `created_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_tenant_id` (`tenant_id`) USING BTREE,
  KEY `idx_role_app_id` (`app_id`) USING BTREE,
  KEY `idx_role_creator_id` (`creator_id`) USING BTREE,
  KEY `idx_role_created_time` (`created_time`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='角色表';

-- ----------------------------
-- Table structure for ibr_role_permit
-- ----------------------------
DROP TABLE IF EXISTS `ibr_role_permit`;
CREATE TABLE `ibr_role_permit` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `role_id` char(32) NOT NULL COMMENT '角色ID',
  `function_id` char(32) NOT NULL COMMENT '功能ID',
  `permit` bit(1) NOT NULL DEFAULT b'0' COMMENT '授权类型:0.拒绝;1.允许',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_func_permit_role_id` (`role_id`) USING BTREE,
  KEY `idx_role_func_permit_function_id` (`function_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='角色功能权限表';

-- ----------------------------
-- Table structure for ibr_role_member
-- ----------------------------
DROP TABLE IF EXISTS `ibr_role_member`;
CREATE TABLE `ibr_role_member` (
  `id` char(32) NOT NULL COMMENT '主键(UUID)',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '成员类型:0.未定义;1.用户;2.用户组;3.职位',
  `role_id` char(32) NOT NULL COMMENT '角色ID',
  `member_id` char(32) NOT NULL COMMENT '成员ID',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_role_member_role_id` (`role_id`) USING BTREE,
  KEY `idx_role_member_member_id` (`member_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT=COMPACT COMMENT='角色成员表';


-- ----------------------------
-- View structure for ibv_user_roles
-- ----------------------------
DROP VIEW IF EXISTS ibv_user_roles;
CREATE VIEW ibv_user_roles AS select
r.tenant_id,
m.role_id,
m.member_id as user_id
from ibr_role r
	join ibr_role_member m on m.role_id = r.id 
where
	type = 1 
union select
	r.tenant_id,
	m.role_id,
	g.user_id
from ibr_role r
	join ibr_role_member m on m.role_id = r.id and m.type = 2
	join ibu_group_member g on g.group_id = m.member_id 
union select
	r.tenant_id,
	m.role_id,
	p.user_id
from ibr_role r
	join ibr_role_member m on m.role_id = r.id and m.type = 3
	join ibo_organize_member p on p.post_id = m.member_id
	join ibo_organize o on o.id = p.post_id;


-- ----------------------------
-- 初始化用户:系统管理员
-- ----------------------------
INSERT ibu_user (`id`, `name`, `account`, `is_builtin`, `creator`, `creator_id`, `created_time`) VALUES
(replace(uuid(), '-', ''), '系统管理员', 'admin', 1, '系统', '00000000000000000000000000000000', now());

-- ----------------------------
-- 初始化租户:因赛特软件
-- ----------------------------
INSERT ibt_tenant (`id`, `code`, `name`, `alias`, `status`, `auditor`, `auditor_id`, `audited_time`, `creator`, `creator_id`, `created_time`) VALUES 
('2564cd559cd340f0b81409723fd8632a', 'TI-00001', '因赛特软件', 'Insight', 1, '系统', '00000000000000000000000000000000', now(), '系统', '00000000000000000000000000000000', now());
INSERT ibt_tenant_user (`id`, `tenant_id`, `user_id`) select replace(uuid(), '-', ''), '2564cd559cd340f0b81409723fd8632a', id from ibu_user;

-- ----------------------------
-- 初始化组织机构:因赛特软件
-- ----------------------------
INSERT ibo_organize (`id`, `tenant_id`, `type`, `index`, `code`, `name`, `alias`, `full_name`, `creator`, `creator_id`, `created_time`) VALUES 
('2564cd559cd340f0b81409723fd8632a', '2564cd559cd340f0b81409723fd8632a', 0, 1, 'TI-001', '因赛特软件有限公司', 'Insight', '因赛特软件', '系统', '00000000000000000000000000000000', now());

-- ----------------------------
-- 初始化应用:管理客户端
-- ----------------------------
INSERT ibs_application (`id`, `index`, `name`, `alias`, `permit_life`, `token_life`, `creator`, `creator_id`, `created_time`) VALUES
('9dd99dd9e6df467a8207d05ea5581125', 1, '因赛特多租户平台', 'MTP', 300000, 7200000, '系统', '00000000000000000000000000000000', now()),
('e46c0d4f85f24f759ad4d86b9505b1d4', 2, '因赛特用户管理系统', 'RMS', 300000, 7200000, '系统', '00000000000000000000000000000000', now());
INSERT ibt_tenant_app (`id`, `tenant_id`, `app_id`, `expire_date`) VALUES
(replace(uuid(), '-', ''), '2564cd559cd340f0b81409723fd8632a', 'e46c0d4f85f24f759ad4d86b9505b1d4', '2800-01-01');

-- ----------------------------
-- 初始化应用:功能导航
-- ----------------------------
INSERT ibs_navigator(`id`, `parent_id`, `app_id`, `type`, `index`, `name`, `module_info`, `creator`, `creator_id`, `created_time`) VALUES
('8c95d6e097f340d6a8d93a3b5631ba39', NULL, '9dd99dd9e6df467a8207d05ea5581125', 1, 1, '运营中心', json_object("iconUrl", "icons/operation.png"), '系统', '00000000000000000000000000000000', now()),
('c02bbc8cfc4f11e99bc30242ac110005', '8c95d6e097f340d6a8d93a3b5631ba39', '9dd99dd9e6df467a8207d05ea5581125', 2, 1, '平台用户', json_object("module", 'Users', "file", 'Platform.dll', "autoLoad", false, "iconUrl", "icons/user.png"), '系统', '00000000000000000000000000000000', now()),
('711aad8daf654bcdb3a126d70191c15c', '8c95d6e097f340d6a8d93a3b5631ba39', '9dd99dd9e6df467a8207d05ea5581125', 2, 2, '租户管理', json_object("module", 'Tenants', "file", 'Platform.dll', "autoLoad", false, "iconUrl", "icons/tenant.png"), '系统', '00000000000000000000000000000000', now()),
('aac02362df4611e9b5650242ac110002', '8c95d6e097f340d6a8d93a3b5631ba39', '9dd99dd9e6df467a8207d05ea5581125', 2, 3, '计划任务', json_object("module", 'Schedules', "file", 'Platform.dll', "autoLoad", true, "iconUrl", "icons/schedul.png"), '系统', '00000000000000000000000000000000', now()),
('33a6d46b337211eaa03a0242ac110004', NULL, '9dd99dd9e6df467a8207d05ea5581125', 1, 2, '基础数据', json_object("iconUrl", "icons/basedata.png"), '系统', '00000000000000000000000000000000', now()),
('d6254874cd2611e9bbd40242ac110008', '33a6d46b337211eaa03a0242ac110004', '9dd99dd9e6df467a8207d05ea5581125', 2, 1, '接口管理', json_object("module", 'Interfaces', "file", 'Setting.dll', "autoLoad", false, "iconUrl", "icons/interface.png"), '系统', '00000000000000000000000000000000', now()),
('60dfc306337311eaa03a0242ac110004', '33a6d46b337211eaa03a0242ac110004', '9dd99dd9e6df467a8207d05ea5581125', 2, 2, '行政区划', json_object("module", 'Areas', "file", 'Data.dll', "autoLoad", false, "iconUrl", "icons/area.png"), '系统', '00000000000000000000000000000000', now()),
('60dfc370337311eaa03a0242ac110004', '33a6d46b337211eaa03a0242ac110004', '9dd99dd9e6df467a8207d05ea5581125', 2, 3, '数据字典', json_object("module", 'Dicts', "file", 'Data.dll', "autoLoad", false, "iconUrl", "icons/dict.png"), '系统', '00000000000000000000000000000000', now()),
('b4eb74e5df4611e9b5650242ac110002', '33a6d46b337211eaa03a0242ac110004', '9dd99dd9e6df467a8207d05ea5581125', 2, 4, '消息场景', json_object("module", 'Scenes', "file", 'Setting.dll', "autoLoad", false, "iconUrl", "icons/scene.png"), '系统', '00000000000000000000000000000000', now()),
('bac908d2df4611e9b5650242ac110002', '33a6d46b337211eaa03a0242ac110004', '9dd99dd9e6df467a8207d05ea5581125', 2, 5, '消息模板', json_object("module", 'Templates', "file", 'Setting.dll', "autoLoad", false, "iconUrl", "icons/templet.png"), '系统', '00000000000000000000000000000000', now()),
('5e4a994ccd2611e9bbd40242ac110008', NULL, '9dd99dd9e6df467a8207d05ea5581125', 1, 3, '系统设置', json_object("iconUrl", "icons/setting.png"), '系统', '00000000000000000000000000000000', now()),
('717895ca14de11ea9ae00242ac110005', '5e4a994ccd2611e9bbd40242ac110008', '9dd99dd9e6df467a8207d05ea5581125', 2, 1, '角色权限', json_object("module", 'Roles', "file", 'Setting.dll', "autoLoad", false, "iconUrl", "icons/role.png"), '系统', '00000000000000000000000000000000', now()),
('a65a562582bb489ea729bb0838bbeff8', '5e4a994ccd2611e9bbd40242ac110008', '9dd99dd9e6df467a8207d05ea5581125', 2, 2, '应用管理', json_object("module", 'Apps', "file", 'Setting.dll', "autoLoad", false, "iconUrl", "icons/resource.png"), '系统', '00000000000000000000000000000000', now()),
('2920d9ed337211eaa03a0242ac110004', NULL, 'e46c0d4f85f24f759ad4d86b9505b1d4', 1, 1, '基础数据', json_object("iconUrl", "icons/basedata.png"), '系统', '00000000000000000000000000000000', now()),
('31baf8c0337311eaa03a0242ac110004', '2920d9ed337211eaa03a0242ac110004', 'e46c0d4f85f24f759ad4d86b9505b1d4', 2, 1, '数据字典', json_object("module", 'Dicts', "file", 'Data.dll', "autoLoad", false, "iconUrl", "icons/dict.png"), '系统', '00000000000000000000000000000000', now()),
('31baf963337311eaa03a0242ac110004', '2920d9ed337211eaa03a0242ac110004', 'e46c0d4f85f24f759ad4d86b9505b1d4', 2, 2, '模板设计', json_object("module", 'Designs', "file", 'Report.dll', "autoLoad", false, "iconUrl", "icons/design.png"), '系统', '00000000000000000000000000000000', now()),
('4b3ac9336dd8496597e603fc7e8f5140', NULL, 'e46c0d4f85f24f759ad4d86b9505b1d4', 1, 3, '系统设置', json_object("iconUrl", "icons/setting.png"), '系统', '00000000000000000000000000000000', now()),
('cdf0ffb178b741b287d1f155d0165112', '4b3ac9336dd8496597e603fc7e8f5140', 'e46c0d4f85f24f759ad4d86b9505b1d4', 2, 1, '用户', json_object("module", 'Users', "file", 'Base.dll', "autoLoad", false, "iconUrl", "icons/user.png"), '系统', '00000000000000000000000000000000', now()),
('b13a3593c4ec4d2fb9432045846f7ff9', '4b3ac9336dd8496597e603fc7e8f5140', 'e46c0d4f85f24f759ad4d86b9505b1d4', 2, 2, '用户组', json_object("module", 'Groups', "file", 'Base.dll', "autoLoad", false, "iconUrl", "icons/group.png"), '系统', '00000000000000000000000000000000', now()),
('100ff6e2748f493586ea4e4cd3f7a4b1', '4b3ac9336dd8496597e603fc7e8f5140', 'e46c0d4f85f24f759ad4d86b9505b1d4', 2, 3, '组织机构', json_object("module", 'Organizes', "file", 'Base.dll', "autoLoad", false, "iconUrl", "icons/organize.png"), '系统', '00000000000000000000000000000000', now()),
('0e74cbb3f9d44bddbd3be3cc702d2a82', '4b3ac9336dd8496597e603fc7e8f5140', 'e46c0d4f85f24f759ad4d86b9505b1d4', 2, 4, '角色权限', json_object("module", 'Roles', "file", 'Base.dll', "autoLoad", false, "iconUrl", "icons/role.png"), '系统', '00000000000000000000000000000000', now());

-- ----------------------------
-- 平台应用
-- ----------------------------
INSERT ibs_function(`id`, `nav_id`, `type`, `index`, `name`, `auth_codes`, `func_info`, `creator`, `creator_id`, `created_time`) VALUES
(replace(uuid(), '-', ''), 'aac02362df4611e9b5650242ac110002', 0, 1, '刷新', 'getSchedule', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'aac02362df4611e9b5650242ac110002', 1, 2, '立即执行', 'executeSchedule', json_object("method", "execute", "iconUrl", "icons/execute.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'aac02362df4611e9b5650242ac110002', 1, 3, '删除', 'deleteSchedule', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'aac02362df4611e9b5650242ac110002', 1, 4, '禁用', 'disableSchedule', json_object("method", "disable", "iconUrl", "icons/disable.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'aac02362df4611e9b5650242ac110002', 1, 5, '启用', 'enableSchedule', json_object("method", "enable", "iconUrl", "icons/enable.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'aac02362df4611e9b5650242ac110002', 0, 6, '查看日志', 'getScheduleLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 0, 1, '刷新', 'getApp', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 0, 2, '新增应用', 'newApp', json_object("method", "newApp", "iconUrl", "icons/newapp.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 3, '编辑', 'editApp', json_object("method", "editApp", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 4, '删除', 'deleteApp', json_object("method", "deleteApp", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 5, '新增导航', 'newNav', json_object("method", "newNav", "iconUrl", "icons/newnav.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 6, '编辑', 'editNav', json_object("method", "editNav", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 7, '删除', 'deleteNav', json_object("method", "deleteNav", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 8, '新增功能', 'newFunc', json_object("method", "newFunc", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 9, '编辑', 'editFunc', json_object("method", "editFunc", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 1, 10, '删除', 'deleteFunc', json_object("method", "deleteFunc", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'a65a562582bb489ea729bb0838bbeff8', 0, 11, '查看日志', 'getAppLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 0, 1, '刷新', 'getTenant', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 0, 2, '新增租户', 'newTenant', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 3, '编辑', 'editTenant', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 4, '删除', 'deleteTenant', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 5, '审核', 'auditTenant', json_object("method", "audit", "iconUrl", "icons/audit.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 6, '禁用', 'disableTenant', json_object("method", "disable", "iconUrl", "icons/disable.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 7, '启用', 'enableTenant', json_object("method", "enable", "iconUrl", "icons/enable.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 8, '绑定应用', 'bindApp', json_object("method", "bind", "iconUrl", "icons/bind.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 9, '解绑应用', 'unbindApp', json_object("method", "unbind", "iconUrl", "icons/unbind.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 1, 10, '续租应用', 'rentTenantApp', json_object("method", "rent", "iconUrl", "icons/rent.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '711aad8daf654bcdb3a126d70191c15c', 0, 11, '查看日志', 'getTenantLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

-- ----------------------------
-- 平台基础数据
-- ----------------------------
(replace(uuid(), '-', ''), 'd6254874cd2611e9bbd40242ac110008', 0, 1, '刷新', 'getConfig', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'd6254874cd2611e9bbd40242ac110008', 0, 2, '新增接口', 'newConfig', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'd6254874cd2611e9bbd40242ac110008', 1, 3, '编辑', 'editConfig', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'd6254874cd2611e9bbd40242ac110008', 1, 4, '删除', 'deleteConfig', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'd6254874cd2611e9bbd40242ac110008', 0, 5, '加载配置', 'loadConfig', json_object("method", "load", "iconUrl", "icons/sync.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'd6254874cd2611e9bbd40242ac110008', 0, 6, '查看日志', 'getConfigLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), '60dfc306337311eaa03a0242ac110004', 0, 1, '刷新', 'getArea', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc306337311eaa03a0242ac110004', 0, 2, '新增区域', 'newArea', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc306337311eaa03a0242ac110004', 1, 3, '编辑', 'editArea', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc306337311eaa03a0242ac110004', 1, 4, '删除', 'deleteArea', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc306337311eaa03a0242ac110004', 0, 5, '查看日志', 'getAreaLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 0, 1, '刷新', 'getDict', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 0, 2, '新增字典', 'newDict', json_object("method", "newDict", "iconUrl", "icons/newdict.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 1, 3, '编辑字典', 'editDict', json_object("method", "editDict", "iconUrl", "icons/editdict.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 1, 4, '删除字典', 'deleteDict', json_object("method", "deleteDict", "iconUrl", "icons/deletedict.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 0, 5, '新增值', 'newValue', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 1, 6, '编辑值', 'editValue', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 1, 7, '删除值', 'deleteValue', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '60dfc370337311eaa03a0242ac110004', 0, 8, '查看日志', 'getDictLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), 'b4eb74e5df4611e9b5650242ac110002', 0, 1, '刷新', 'getScene,getSceneTemplate', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b4eb74e5df4611e9b5650242ac110002', 0, 2, '新增场景', 'newScene', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b4eb74e5df4611e9b5650242ac110002', 1, 3, '编辑', 'editScene', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b4eb74e5df4611e9b5650242ac110002', 1, 4, '删除', 'deleteScene', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b4eb74e5df4611e9b5650242ac110002', 1, 5, '添加配置', 'addSceneTemplate', json_object("method", "addConfig", "iconUrl", "icons/add.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b4eb74e5df4611e9b5650242ac110002', 1, 6, '移除配置', 'removeSceneTemplate', json_object("method", "removeConfig", "iconUrl", "icons/remove.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b4eb74e5df4611e9b5650242ac110002', 0, 7, '查看日志', 'getSceneLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), 'bac908d2df4611e9b5650242ac110002', 0, 1, '刷新', 'getTemplate', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'bac908d2df4611e9b5650242ac110002', 0, 2, '新增模板', 'newTemplate', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'bac908d2df4611e9b5650242ac110002', 1, 3, '编辑', 'editTemplate', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'bac908d2df4611e9b5650242ac110002', 1, 4, '删除', 'deleteTemplate', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'bac908d2df4611e9b5650242ac110002', 1, 5, '禁用', 'disableTemplate', json_object("method", "disable", "iconUrl", "icons/disable.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'bac908d2df4611e9b5650242ac110002', 1, 6, '启用', 'enableTemplate', json_object("method", "enable", "iconUrl", "icons/enable.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'bac908d2df4611e9b5650242ac110002', 0, 7, '查看日志', 'getTemplateLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

-- ----------------------------
-- 平台用户权限
-- ----------------------------
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 0, 1, '刷新', 'getUser', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 0, 2, '新增用户', 'newUser', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 1, 3, '编辑', 'editUser', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 1, 4, '删除', 'deleteUser', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 1, 5, '封禁', 'bannedUser', json_object("method", "disable", "iconUrl", "icons/disable.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 1, 6, '解封', 'releaseUser', json_object("method", "enable", "iconUrl", "icons/enable.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 1, 7, '重置密码', 'resetPassword', json_object("method", "reset", "iconUrl", "icons/reset.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'c02bbc8cfc4f11e99bc30242ac110005', 0, 8, '查看日志', 'getUserLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), '717895ca14de11ea9ae00242ac110005', 0, 1, '刷新', 'getRole', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '717895ca14de11ea9ae00242ac110005', 0, 2, '新增角色', 'newRole,setRoleFunc', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '717895ca14de11ea9ae00242ac110005', 1, 3, '编辑', 'editRole,setRoleFunc', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '717895ca14de11ea9ae00242ac110005', 1, 4, '删除', 'deleteRole', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '717895ca14de11ea9ae00242ac110005', 1, 5, '添加成员', 'addRoleMember', json_object("method", "addMember", "iconUrl", "icons/add.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '717895ca14de11ea9ae00242ac110005', 1, 6, '移除成员', 'removeRoleMember', json_object("method", "removeMember", "iconUrl", "icons/remove.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '717895ca14de11ea9ae00242ac110005', 0, 9, '查看日志', 'getRoleLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),


-- ----------------------------
-- 租户基础数据
-- ----------------------------
(replace(uuid(), '-', ''), '31baf8c0337311eaa03a0242ac110004', 0, 1, '刷新', 'getDict', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf8c0337311eaa03a0242ac110004', 0, 2, '新增值', 'newValue', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf8c0337311eaa03a0242ac110004', 1, 3, '编辑值', 'editValue', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf8c0337311eaa03a0242ac110004', 1, 4, '删除值', 'deleteValue', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf8c0337311eaa03a0242ac110004', 0, 5, '查看日志', 'getDictLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 0, 1, '刷新', 'getTemplet', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 0, 2, '新增分类', 'newTempletCategory', json_object("method", "newCat", "iconUrl", "icons/newcat.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 1, 3, '编辑分类', 'editTempletCategory', json_object("method", "editCat", "iconUrl", "icons/editcat.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 1, 4, '删除分类', 'deleteTempletCategory', json_object("method", "deleteCat", "iconUrl", "icons/deletecat.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 0, 5, '复制模板', 'copy', json_object("method", "copy", "iconUrl", "icons/copy.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 1, 6, '编辑', 'editTemplet', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 1, 7, '删除', 'deleteTemplet', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 1, 8, '设计', 'design', json_object("method", "design", "iconUrl", "icons/design.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 1, 9, '导入', 'import', json_object("method", "import", "iconUrl", "icons/import.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 1, 10, '导出', 'export', json_object("method", "export", "iconUrl", "icons/export.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '31baf963337311eaa03a0242ac110004', 0, 11, '查看日志', 'getTempletLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

-- ----------------------------
-- 租户系统设置
-- ----------------------------
(replace(uuid(), '-', ''), 'cdf0ffb178b741b287d1f155d0165112', 0, 1, '刷新', 'getUser', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'cdf0ffb178b741b287d1f155d0165112', 0, 2, '新增用户', 'newUser', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'cdf0ffb178b741b287d1f155d0165112', 1, 3, '编辑', 'editUser', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'cdf0ffb178b741b287d1f155d0165112', 1, 4, '重置密码', 'resetPassword', json_object("method", "reset", "iconUrl", "icons/reset.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'cdf0ffb178b741b287d1f155d0165112', 0, 5, '邀请用户', 'inviteUser', json_object("method", "inviteUser", "iconUrl", "icons/add.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'cdf0ffb178b741b287d1f155d0165112', 1, 6, '清退用户', 'removeUser', json_object("method", "removeUser", "iconUrl", "icons/remove.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'cdf0ffb178b741b287d1f155d0165112', 0, 7, '查看日志', 'getUserLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), 'b13a3593c4ec4d2fb9432045846f7ff9', 0, 1, '刷新', 'getGroup', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b13a3593c4ec4d2fb9432045846f7ff9', 0, 2, '新增用户组', 'newGroup', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b13a3593c4ec4d2fb9432045846f7ff9', 1, 3, '编辑', 'editGroup', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b13a3593c4ec4d2fb9432045846f7ff9', 1, 4, '删除', 'deleteGroup', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b13a3593c4ec4d2fb9432045846f7ff9', 1, 5, '添加成员', 'addGroupMember', json_object("method", "addMember", "iconUrl", "icons/add.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b13a3593c4ec4d2fb9432045846f7ff9', 1, 6, '移除成员', 'removeGroupMember', json_object("method", "removeMember", "iconUrl", "icons/remove.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), 'b13a3593c4ec4d2fb9432045846f7ff9', 0, 7, '查看日志', 'getGroupLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), '100ff6e2748f493586ea4e4cd3f7a4b1', 0, 1, '刷新', 'getOrganize', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '100ff6e2748f493586ea4e4cd3f7a4b1', 0, 2, '新增机构', 'newOrganize', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '100ff6e2748f493586ea4e4cd3f7a4b1', 1, 3, '编辑', 'editOrganize', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '100ff6e2748f493586ea4e4cd3f7a4b1', 1, 4, '删除', 'deleteOrganize', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '100ff6e2748f493586ea4e4cd3f7a4b1', 1, 5, '添加成员', 'addOrganizeMember', json_object("method", "addMember", "iconUrl", "icons/add.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '100ff6e2748f493586ea4e4cd3f7a4b1', 1, 6, '移除成员', 'removeOrganizeMember', json_object("method", "removeMember", "iconUrl", "icons/remove.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '100ff6e2748f493586ea4e4cd3f7a4b1', 0, 7, '查看日志', 'getOrganizeLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),

(replace(uuid(), '-', ''), '0e74cbb3f9d44bddbd3be3cc702d2a82', 0, 1, '刷新', 'getRole', json_object("method", "refresh", "iconUrl", "icons/refresh.png", "beginGroup", true, "hideText", true), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '0e74cbb3f9d44bddbd3be3cc702d2a82', 0, 2, '新增角色', 'newRole,setRoleFunc', json_object("method", "newItem", "iconUrl", "icons/new.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '0e74cbb3f9d44bddbd3be3cc702d2a82', 1, 3, '编辑', 'editRole,setRoleFunc', json_object("method", "editItem", "iconUrl", "icons/edit.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '0e74cbb3f9d44bddbd3be3cc702d2a82', 1, 4, '删除', 'deleteRole', json_object("method", "deleteItem", "iconUrl", "icons/delete.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '0e74cbb3f9d44bddbd3be3cc702d2a82', 1, 5, '添加成员', 'addRoleMember', json_object("method", "addMember", "iconUrl", "icons/add.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '0e74cbb3f9d44bddbd3be3cc702d2a82', 1, 6, '移除成员', 'removeRoleMember', json_object("method", "removeMember", "iconUrl", "icons/remove.png", "beginGroup", false, "hideText", false), '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '0e74cbb3f9d44bddbd3be3cc702d2a82', 0, 9, '查看日志', 'getRoleLog', json_object("method", "log", "iconUrl", "icons/log.png", "beginGroup", true, "hideText", false), '系统', '00000000000000000000000000000000', now());

-- ----------------------------
-- 初始化角色:系统管理员
-- ----------------------------
insert ibr_role (id, tenant_id, app_id, name, remark, is_builtin, creator, creator_id, `created_time`) values
(replace(uuid(), '-', ''), NULL, '9dd99dd9e6df467a8207d05ea5581125', '平台管理员', '内置角色，角色成员为系统管理员', 0, '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), NULL, 'e46c0d4f85f24f759ad4d86b9505b1d4', '系统管理员', '系统管理员角色模板', 1, '系统', '00000000000000000000000000000000', now()),
(replace(uuid(), '-', ''), '2564cd559cd340f0b81409723fd8632a', 'e46c0d4f85f24f759ad4d86b9505b1d4', '系统管理员', NULL, 0, '系统', '00000000000000000000000000000000', now());

-- ----------------------------
-- 初始化用户组:系统管理员
-- ----------------------------
insert `ibu_group`(`id`, `tenant_id`, `code`, `name`, `remark`, `is_builtin`, `creator`, `creator_id`, `created_time`) values 
(replace(uuid(), '-', ''), '2564cd559cd340f0b81409723fd8632a', '0001', '系统管理员', '内置用户组,系统管理员组', b'1', '系统', '00000000000000000000000000000000', now());

-- ----------------------------
-- 初始化用户组成员:系统管理员
-- ----------------------------
insert `ibu_group_member`(`id`, `group_id`, `user_id`) 
select replace(uuid(), '-', ''), g.id, u.id from ibu_user u, ibu_group g;

-- ----------------------------
-- 初始化角色成员:平台管理员
-- ----------------------------
insert ibr_role_member(id, `type`, role_id, member_id)
select replace(uuid(), '-', ''), 1, (select id from ibr_role where app_id = '9dd99dd9e6df467a8207d05ea5581125'), id from ibu_user;

-- ----------------------------
-- 初始化角色成员:系统管理员
-- ----------------------------
insert ibr_role_member(id, `type`, role_id, member_id)
select replace(uuid(), '-', ''), 2, (select id from ibr_role where tenant_id = '2564cd559cd340f0b81409723fd8632a'), id from ibu_group;

-- ----------------------------
-- 初始化功能权限
-- ---------------------------- 
ALTER TABLE `ibr_role_permit` 
MODIFY COLUMN `id` char(36) NOT NULL COMMENT '主键(UUID)' FIRST;
INSERT `ibr_role_permit`(`id`, `role_id`, `function_id`, `permit`) 
select uuid(), r.id, f.id, 1
from ibr_role r
join ibs_navigator n on n.app_id = r.app_id
join ibs_function f on f.nav_id = n.id;
update ibr_role_permit set id = replace(id, '-', '');
ALTER TABLE `ibr_role_permit` 
MODIFY COLUMN `id` char(32) NOT NULL COMMENT '主键(UUID)' FIRST;

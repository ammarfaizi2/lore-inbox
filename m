Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751267AbWDCI2w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbWDCI2w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:28:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWDCI2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:28:52 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:39814 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751267AbWDCI2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:28:51 -0400
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.1-RC1
From: Keith Owens <kaos@sgi.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-rc1 core_sys_select incompatible pointer types
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 03 Apr 2006 18:28:46 +1000
Message-ID: <25355.1144052926@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.17-rc1, ia64, gcc 3.3.3

fs/select.c: In function `core_sys_select':
fs/select.c:339: warning: assignment from incompatible pointer type
fs/select.c:376: warning: comparison of distinct pointer types lacks a cast


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264330AbUD1NVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbUD1NVo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:21:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbUD1NVo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:21:44 -0400
Received: from fw.osdl.org ([65.172.181.6]:32713 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264330AbUD1NVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:21:44 -0400
Date: Wed, 28 Apr 2004 06:21:42 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200404281321.i3SDLg3h012404@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.6-rc3 - 2004-04-27.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/dquot.c:1328: warning: label `out' defined but not used

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264271AbUE2MqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264271AbUE2MqA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 08:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264623AbUE2MqA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 08:46:00 -0400
Received: from fw.osdl.org ([65.172.181.6]:48289 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264271AbUE2Mp7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 08:45:59 -0400
Date: Sat, 29 May 2004 05:45:58 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200405291245.i4TCjw0O001451@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7-rc1 - 2004-05-28.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/ixgb/ixgb_main.c:1593: warning: unused variable `hw'

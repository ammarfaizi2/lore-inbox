Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbUCJNca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 08:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbUCJNca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 08:32:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:49617 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262608AbUCJNc3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 08:32:29 -0500
Date: Wed, 10 Mar 2004 05:32:27 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403101332.i2ADWRUG005724@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.4-rc3 - 2004-03-09.22.30) - 4 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/ipv6/addrconf.c:2558: warning: `inet6_fill_ifmcaddr' defined but not used
net/ipv6/addrconf.c:2595: warning: `inet6_fill_ifacaddr' defined but not used
net/ipv6/addrconf.c:2638: warning: unused variable `ifmca'
net/ipv6/addrconf.c:2639: warning: unused variable `ifaca'

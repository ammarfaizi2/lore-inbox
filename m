Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267417AbUIJOSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267417AbUIJOSs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 10:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267423AbUIJOSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 10:18:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:22991 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267417AbUIJOSr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 10:18:47 -0400
Date: Fri, 10 Sep 2004 07:18:45 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200409101418.i8AEIjjJ020039@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc1 - 2004-09-09.21.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/tulip/dmfe.c:1808: warning: passing arg 1 of `__le16_to_cpup' from incompatible pointer type
drivers/net/tulip/dmfe.c:1820: warning: passing arg 1 of `__le32_to_cpup' from incompatible pointer type

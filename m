Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266850AbUBGL03 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Feb 2004 06:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266832AbUBGL03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Feb 2004 06:26:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:62183 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266850AbUBGL02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Feb 2004 06:26:28 -0500
Date: Sat, 7 Feb 2004 03:26:26 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402071126.i17BQQGr019959@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.3-rc1 - 2004-02-06.22.30) - 6 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/arcnet/com20020-isa.c:188: warning: unused variable `dev'
drivers/net/arcnet/com20020-isa.c:189: warning: unused variable `lp'
drivers/net/ibmlana.c:910: warning: `ibmlana_probe' defined but not used
sound/isa/dt019x.c:147: warning: long unsigned int format, int arg (arg 5)
sound/isa/dt019x.c:147: warning: long unsigned int format, int arg (arg 6)
sound/isa/dt019x.c:168: warning: long unsigned int format, int arg (arg 5)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTIEEpi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 00:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbTIEEpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 00:45:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:59816 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262049AbTIEEpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 00:45:38 -0400
Date: Thu, 4 Sep 2003 21:49:34 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200309050449.h854nYgd025194@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 - 2 New warnings
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/net/smc-mca.c:272: warning: assignment makes integer from pointer without a cast
drivers/scsi/qla1280.c:952: warning: `check_region' is deprecated (declared at include/linux/ioport.h:117)

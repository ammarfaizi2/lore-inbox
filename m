Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261154AbUCPSMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbUCPSMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:12:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:41658 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261154AbUCPSMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:12:23 -0500
Date: Tue, 16 Mar 2004 10:12:22 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200403161812.i2GICMJJ018276@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.5-rc1 - 2004-03-15.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/pcmcia/i82365.c:71: warning: `version' defined but not used
drivers/pcmcia/tcic.c:64: warning: `version' defined but not used

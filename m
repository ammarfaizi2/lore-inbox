Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUBEMH0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 07:07:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265061AbUBEMH0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 07:07:26 -0500
Received: from fw.osdl.org ([65.172.181.6]:29671 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264916AbUBEMGb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 07:06:31 -0500
Date: Thu, 5 Feb 2004 04:06:29 -0800
From: John Cherry <cherry@osdl.org>
Message-Id: <200402051206.i15C6Tt6015954@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.2 - 2004-02-04.22.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/BusLogic.c:3556: warning: `BusLogic_AbortCommand' defined but not used

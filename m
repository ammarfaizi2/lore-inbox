Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264646AbUEYMoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264646AbUEYMoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 08:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264662AbUEYMoQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 08:44:16 -0400
Received: from fw.osdl.org ([65.172.181.6]:64705 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264646AbUEYMoQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 08:44:16 -0400
Date: Tue, 25 May 2004 05:44:15 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200405251244.i4PCiFJ6006192@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.7-rc1 - 2004-05-24.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/dpt_i2o.c:169: warning: `dptids' defined but not used
drivers/scsi/tmscsim.c:521: warning: `dc390_setup' defined but not used

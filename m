Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264645AbUEKMjO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264645AbUEKMjO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 08:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264669AbUEKMjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 08:39:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:64422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264645AbUEKMjN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 08:39:13 -0400
Date: Tue, 11 May 2004 05:39:11 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200405111239.i4BCdB3C022899@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.6 - 2004-05-10.22.30) - 2 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/scsi/pcmcia/qlogic_stub.c:80: warning: initialization from incompatible pointer type
drivers/scsi/qlogicfas.c:190: warning: initialization from incompatible pointer type

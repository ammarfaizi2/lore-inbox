Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265132AbTLRN1h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 08:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265136AbTLRN1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 08:27:37 -0500
Received: from corvette.lateapex.net ([64.236.104.2]:17329 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265132AbTLRN1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 08:27:36 -0500
From: Jason Van Patten <jvp@lateapex.net>
Message-Id: <200312181327.hBIDRXEP006862@localhost.localdomain>
Subject: v2.6.0 Support for Adaptec SCSI RAID
To: linux-kernel@vger.kernel.org (linux)
Date: Thu, 18 Dec 2003 08:27:32 -0500 (EST)
Reply-To: jvp@lateapex.net
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey folks -

In the 2.6 tree, the driver drivers/scsi/dpt_i2o.c has a #error in it that
prevents it from being compiled.  The note in the file is:

#error Please convert me to Documentation/DMA-mapping.txt

Is anyone actively working on converting this driver to 2.6?  I've
tried contacting the author, Deanna Bonds at Adaptec, but her email stopped
working.  I'm not sure if she's no longer with Adaptec, or changed her email
address so as to stop getting kernel questions. :-)

In either case, I have two boxen at home with the Adaptec SCSI RAID
controllers, and I'd like to move them from 2.4 to 2.6.  Can anyone help?

Thanks!

jas
-- 
Jason Van Patten
AOL IM: Jason VP 


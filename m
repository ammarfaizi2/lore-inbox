Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265154AbSLXP4A>; Tue, 24 Dec 2002 10:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265236AbSLXP4A>; Tue, 24 Dec 2002 10:56:00 -0500
Received: from pointblue.com.pl ([62.121.131.135]:2063 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id <S265154AbSLXPz7>;
	Tue, 24 Dec 2002 10:55:59 -0500
Subject: oups in 2.4.20
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8-3mdk 
Date: 24 Dec 2002 17:04:04 +0100
Message-Id: <1040745846.2240.5.camel@bobo.chello.pl>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've encountered unrecovable "oups" in 2.4.20,  but i haven't found any
patch to 2.4.20 that will allow me to save this message on floppy. 
Is there any ? Maybe somebody can help me to save those messages.

I can tell more about this bug. I've got pIII 1.3 ghz on i815
intelboard.
One disk and CD-W54E cdrw teac drive. Kernel was compiled with gcc
3.2.1. Distro is a mandrake 9.
I've got oups on any access to this cdrom drive, with or without
ide-scsi module. The same error is present in 2.4.21-pre2.

 
-- 
	   	Grzegorz Jaskiewicz 
	   C/C++/PERL/PHP/SQL programmer


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317777AbSGPH4u>; Tue, 16 Jul 2002 03:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSGPH4t>; Tue, 16 Jul 2002 03:56:49 -0400
Received: from mailer.psp.ucl.ac.be ([130.104.83.246]:55426 "EHLO
	guppy.psp.ucl.ac.be") by vger.kernel.org with ESMTP
	id <S317777AbSGPH4t>; Tue, 16 Jul 2002 03:56:49 -0400
Mime-Version: 1.0
Message-Id: <p05100302b9597d1e930e@[130.104.82.36]>
Date: Tue, 16 Jul 2002 09:59:37 +0200
To: linux-kernel@vger.kernel.org
From: Bernard Paris <Bernard.Paris@psp.ucl.ac.be>
Subject: crash while dumping on SCSI tapes
Cc: bernard.paris@psp.ucl.ac.be
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi from Belgium,

I encounter several severe server crashes, mostly while dumping on 
SCSI tapes (HP DAT and HP DLT). This appear on 3 similar machines 
(that excludes hardware problem). Crash is severe because when they 
occur, the system is completely frozen, with a black console. No 
error message. I just need to switch off then on.
I never have had this problem when I was previously running 2.0.36 
kernel on same hardware.

- all  disks are SCSI
- SCSI card Adaptec 2940UW
- processor is AMD K6-266 MHz
- for 1 year now, I've been using several 2.4.x kernel versions (-> 2.17)
- last I've last tried kernel 2.17 patched with 
"linux-aic7xxx-6.2.5-2.4.17.patch"
(cf. http://people.freebsd.org/~gibbs/linux/)
- glibc 2.2.2-10,  X is not running




please cc:  answers to bernard.paris@psp.ucl.ac.be

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264950AbTBTI16>; Thu, 20 Feb 2003 03:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbTBTI15>; Thu, 20 Feb 2003 03:27:57 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:16005 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S264950AbTBTI14>; Thu, 20 Feb 2003 03:27:56 -0500
Message-ID: <20030220083754.23733.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Thu, 20 Feb 2003 16:37:54 +0800
Subject: Adding 272120k swap on /dev/hda7.  Priority:-2 extents:1
X-Originating-Ip: 194.185.48.246
X-Originating-Server: ws5-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
booting the 2.5.62 I see:

Adding 272120k swap on /dev/hda7.  Priority:-1 extents:1
NTFS volume version 3.0.
hdc: DMA disabled
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
warning: process `update' used the obsolete bdflush system call
Fix your initscripts?
mtrr: MTRR 2 not used
mtrr: MTRR 2 not used
Adding 272120k swap on /dev/hda7.  Priority:-2 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-3 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-4 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-5 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-6 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-7 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-8 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-9 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-10 extents:1
Adding 272120k swap on /dev/hda7.  Priority:-11 extents:1
mtrr: MTRR 2 not used
mtrr: MTRR 2 not used

What happened ?

Ciao,
       Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze

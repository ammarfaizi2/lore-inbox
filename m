Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSGHSTR>; Mon, 8 Jul 2002 14:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSGHSR5>; Mon, 8 Jul 2002 14:17:57 -0400
Received: from purple.csi.cam.ac.uk ([131.111.8.4]:43186 "EHLO
	purple.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S317034AbSGHSRq>; Mon, 8 Jul 2002 14:17:46 -0400
Message-Id: <5.1.0.14.2.20020708191916.028f0060@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 08 Jul 2002 19:21:04 +0100
To: Axel Siebenwirth <axel@hh59.org>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: NTFS: 2.0.15 - Fake inodes based attribute i/o via the
  page cache, fixes, cleanups
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020708180423.GA4676@neon.hh59.org>
References: <E17Rcbj-0005sw-00@storm.christs.cam.ac.uk>
 <E17Rcbj-0005sw-00@storm.christs.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

At 19:04 08/07/02, Axel Siebenwirth wrote:
>Has there been any progress in the work on NTFS write support on NTFS W2k+
>filesystems? Is it still the lack of information on the filesystem from
>Microsoft?

Write support has not been started yet. The read-only driver is shaping up 
nicely however so it should be possible to start on write support in the 
next few weeks. But don't hold your breath. It is going to take a looong 
time to have full write support...

Best regards,

         Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/


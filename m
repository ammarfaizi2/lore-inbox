Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279305AbRKVNXY>; Thu, 22 Nov 2001 08:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279201AbRKVNXO>; Thu, 22 Nov 2001 08:23:14 -0500
Received: from yellow.csi.cam.ac.uk ([131.111.8.67]:44016 "EHLO
	yellow.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S279307AbRKVNXE>; Thu, 22 Nov 2001 08:23:04 -0500
Message-Id: <5.1.0.14.2.20011122131259.00a87bc0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 22 Nov 2001 13:21:41 +0000
To: Urban Widmark <urban@teststation.com>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Filesize limit on SMBFS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BFCF740.1030009@century.cz>
In-Reply-To: <Pine.LNX.4.30.0111221305520.4258-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Urban Widmark wrote:
>On Thu, 22 Nov 2001, Petr Tite(ra wrote:
>>is maximum file size on SMBFS really 2GB? I cannot create file bigger 
>>than that.
>Yes.
>I have patches if you want to be my victim^Wtester.

I am in a masochistic mood today so can I be your victim, too? (-;

Seriously, I can test with all of w9x/NT/2k/XP as servers and I need the 
2GB limit aleviated, too, so please email me the [gb]zipped patch (or a URL).

>>Let me know which 2.4 kernel you are using.

At the moment I am using 2.4.15-pre4 + NTFS TNG but I am happy to use any 
2.4.x kernel. make bzImage on my athlon takes only 3 minutes...

Cheers,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/


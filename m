Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSFNFd5>; Fri, 14 Jun 2002 01:33:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317438AbSFNFd4>; Fri, 14 Jun 2002 01:33:56 -0400
Received: from mail-hou.myfirstlink.net ([24.219.4.119]:46855 "EHLO i3s.net")
	by vger.kernel.org with ESMTP id <S317300AbSFNFdz>;
	Fri, 14 Jun 2002 01:33:55 -0400
Message-ID: <3D098044.E7A41E24@optelnow.net>
Date: Fri, 14 Jun 2002 00:33:56 -0500
From: Kyle Davenport <kdd@optelnow.net>
Organization: Davenport Consulting
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: netscape bug following 2.4.18 upgrade
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I won't elaborate yet, unless I see a pattern.  Just posting this in
case someone else has a similar problem.
This was first time for this bug.   netscape started core dumping on
start up.  strace showed thousands of failed gettimeofday calls up to
the memory violation.  No logout's , killing other app's, restarting X,
whatever would fix the problem until I rebooted.

--
Kyle Davenport - unix sys admin consultant - Dallas TX


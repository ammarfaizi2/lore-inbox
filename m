Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262528AbSJEUQB>; Sat, 5 Oct 2002 16:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262541AbSJEUQB>; Sat, 5 Oct 2002 16:16:01 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:62644 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S262528AbSJEUQB>;
	Sat, 5 Oct 2002 16:16:01 -0400
Date: Sat, 5 Oct 2002 22:21:36 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210052021.WAA04976@harpo.it.uu.se>
To: tmolina@cox.net
Subject: Re: 2.5 Problem Report Status
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002 11:57:59 -0500 (CDT), Thomas Molina wrote:
>-------------------------------------------------------------------------
>   open                   29 Sep 2002 IDE problems on prePCI
>   8. http://marc.theaimsgroup.com/?l=linux-kernel&m=103277899317468&w=2
>
>Mikael Pettersson <mikpe@csd.uu.se> reported this problem and proposed a 
>patch.  Was the patch accepted, and did it fix the problem?

The patch was for minor subproblem, not the instant reboot problem.
The reboot still occurs in 2.5.40.

Another issue: initrd appears to be broken since 2.5.38. See the
"initrd breakage in 2.5.38-2.5.40" thread.

/Mikael

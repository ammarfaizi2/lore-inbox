Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSJLRY1>; Sat, 12 Oct 2002 13:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261306AbSJLRY0>; Sat, 12 Oct 2002 13:24:26 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:54032 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S261302AbSJLRY0>;
	Sat, 12 Oct 2002 13:24:26 -0400
From: Rene Blokland <reneb@cistron.nl>
Subject: 2.5.4x booting from floppy or loadlin
Date: Sat, 12 Oct 2002 19:16:05 +0200
Organization: Cistron
Message-ID: <slrnaqgm6k.he.reneb@orac.aais.org>
References: <1034295079.3da61727ec718@webmail.health.ufl.edu> <3DA61990.8060607@mvista.com>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1034443783 20335 195.64.94.30 (12 Oct 2002 17:29:43 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
It is not possible anymore from dos with loadlin and from a floppy which
contains a kernel image written with dd, It used to work for some years.
My system is arch i386. gcc-3.2 glibc-3.2.1
What happens is:

Uncompressing Linux ...
ran out of input data

  --System halted  

Any clues?
-- 
Groeten / Regards, Rene J. Blokland


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbTADSAu>; Sat, 4 Jan 2003 13:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTADSAu>; Sat, 4 Jan 2003 13:00:50 -0500
Received: from h-64-105-35-183.SNVACAID.covad.net ([64.105.35.183]:54919 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S266986AbTADSAt>; Sat, 4 Jan 2003 13:00:49 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sat, 4 Jan 2003 10:09:14 -0800
Message-Id: <200301041809.KAA06893@adam.yggdrasil.com>
To: andre@linux-ide.org
Subject: Re: Honest does not pay here ...
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	I believe that the illegality of proprietary kernel modules
has resulting in more GPL-compatible kernel code than without such
a restriction.

	Perhaps more people would initially write contributions in the
absense of such a restriction, but my experience has been that, given
that choice, enough contributors eventually evolve their policies to
something not sufficiently free that there is less in total to build
on, and the net result is that software does not advance in the long
term as quickly as with something like the GPL.  That is one reason
why this Berkeley alumnus decided to bet on Linux rather than BSD back
in 1992. It's a complex empirical question.  I believe that copying
conditions have been *one* of the determining factors in adoption of
Linux versus Berkeley Software Distribution (and I'm not a BSD
detractor; I'd like to see Linux distributions that could boot dual
boot a BSD kernel with Linux-compatible system calls, but I digress).

	This brings me to my suggestion for how you could legally
accomplish what you're trying to do with only modest change in your
procedures.  You could do your proprietary work on BSD and port any
GPL-compatible stuff that you want to release to Linux.  I expect the
BSD people would probably welcome you and it might even improve
communication and reduce duplication of effort between BSD and Linux
camps.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

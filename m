Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269260AbTCBSG7>; Sun, 2 Mar 2003 13:06:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269262AbTCBSG7>; Sun, 2 Mar 2003 13:06:59 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:18073 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S269260AbTCBSG7>; Sun, 2 Mar 2003 13:06:59 -0500
Subject: Re: perfctr-2.4.6 released
From: Albert Cahalan <albert@users.sf.net>
To: mikpe@user.it.uu.se
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 02 Mar 2003 13:13:40 -0500
Message-Id: <1046628821.1111.354.camel@cube>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson writes:

> perfctr-2.4.6 is now available at the usual place:
> http://www.csd.uu.se/~mikpe/linux/perfctr/

So, what is it? I figure it does profiling, but that
sure is vague. The SourceForge site is pretty empty too.
>From freshmeat.net and an ANNOUNCE-2.5.0-pre1 file, I'm
guessing you made some user-readable x86 registers be
per-process instead of system-wide, but maybe you've
done much more or less.

Does it use the oprofile interface? (why or why not?)
Does it use the IA-64 perfmon system call?
Does it support the Pentium-MMX in an old PC?
Does it support the PowerPC MPC7400 ("G4") in a Mac?
(if not, what would porting involve?)
Does it handle the kernel itself?
Does it handle stripped dynamic libraries?
Does it handle unmodified executables? (regular, -s, -g)
Does it work without root privileges?
Does it unmangle names for C++ code?



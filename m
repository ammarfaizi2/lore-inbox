Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315235AbSEVVzL>; Wed, 22 May 2002 17:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315162AbSEVVzK>; Wed, 22 May 2002 17:55:10 -0400
Received: from inje.iskon.hr ([213.191.128.16]:55952 "EHLO inje.iskon.hr")
	by vger.kernel.org with ESMTP id <S314835AbSEVVzJ>;
	Wed, 22 May 2002 17:55:09 -0400
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@zip.com.au>
Subject: 2.5.17 & ext3 & sard patches
Reply-To: zlatko.calusic@iskon.hr
X-Face: s71Vs\G4I3mB$X2=P4h[aszUL\%"`1!YRYl[JGlC57kU-`kxADX}T/Bq)Q9.$fGh7lFNb.s
 i&L3xVb:q_Pr}>Eo(@kU,c:3:64cR]m@27>1tGl1):#(bs*Ip0c}N{:JGcgOXd9H'Nwm:}jLr\FZtZ
 pri/C@\,4lW<|jrq^<):Nk%Hp@G&F"r+n1@BoH
From: Zlatko Calusic <zlatko.calusic@iskon.hr>
Date: Wed, 22 May 2002 23:55:04 +0200
In-Reply-To: <3CE93FAF.642F3E60@zip.com.au> (Andrew Morton's message of
 "Mon, 20 May 2002 11:25:51 -0700")
Message-ID: <87vg9f4zlz.fsf_-_@atlas.iskon.hr>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:
>
> I'll do a bit more ext3 testing than I have been - I run
> ext3 on my test box as a "stable base" while I develop stuff
> against ext2 on test partitions, and I haven't observed any
> problems.  So I guess I need to spend more time testing
> ext3 this week.
>

Thank you Andrew! 2.5.17 runs great at least in writeback and journal
modes of ext3. I did lots of testing and I can't break it.

BTW, for interesting parties, there is a fresh sard patch for 2.5.17
at the standard place: http://linux.inet.hr/

Enjoy and don't push your disks close to 100% busy, they need some
rest, too. :)
-- 
Zlatko

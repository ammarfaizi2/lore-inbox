Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270481AbTGSTsD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270502AbTGSTsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:48:02 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:31507 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S270481AbTGSTr5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:47:57 -0400
To: Larry McVoy <lm@work.bitmover.com>
Cc: Larry McVoy <lm@bitmover.com>,
       Christian Reichert <c.reichert@resolution.de>,
       John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
       linux-kernel@vger.kernel.org, rms@gnu.org, Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Mail-Copies-To: nobody
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
	<1058626962.30424.6.camel@stargate>
	<plopm3lluu8mv0.fsf@drizzt.kilobug.org>
	<20030719172311.GA23246@work.bitmover.com>
	<plopm3he5i8l4h.fsf@drizzt.kilobug.org>
	<20030719181249.GA24197@work.bitmover.com>
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Sat, 19 Jul 2003 22:05:12 +0200
In-Reply-To: <20030719181249.GA24197@work.bitmover.com> (Larry McVoy's
 message of "Sat, 19 Jul 2003 11:12:49 -0700")
Message-ID: <plopm38yqu8epz.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 > On Sat, Jul 19, 2003 at 07:46:54PM +0200, Ga?l Le Mignot wrote:
 >> Hello Larry!
 >> 
 >> Sat, 19 Jul 2003 10:23:11 -0700, you wrote: 
 >> 
 >> >> - GNU/Hurd, the  whole systems, is  actually GNU tools  (libc, linker,
 >> >> ...)  on top  of the  GNU Hurd  (set of  servers) and  the  GNU Mach
 >> >> microkernel.
 >> 
 >> > Mach wasn't written by GNU, it's a BSD based kernel
 >> 
 >> Totally wrong. You're confusing the  Mach operating system (with UX, a
 >> BSD-server on top of the  Mach micro-kernel) and the Mach micro-kernel
 >> itself.

 > The microkernel part of any reasonable microkernel is tiny.  The QNX 
 > microkernel used to fit in a 4K instruction cache.  To say that the
 > microkernel is the operating system is ludicrous, that's like say
 > this series of 5 instructions which happen to get run a lot are the
 > whole program.

You completly missed the point.

The part  use by the  GNU Hurd is  only the Mach microkernel,  not the
Mach operating system in a whole.

 >> > pried apart into chunks by people at CMU.
 >> 
 >> GNU Mach is  a modified version of OSF Mach  which is modified version
 >> of CMU Mach.

 > Whatever.  That's your label.  Personally, I despise this business of
 > taking someone else's code and renaming it.  It's not GNU code, the
 > GNU people didn't write it.

We did  it with  the agreement  of the original  authors, and  then we
changed it.   Should we call our  modified version with  the same name
than the original one ? That would be bad, indeed !

 >> Maybe  for  you,  an  OS  is  drivers.  For  me,  it's  a  design,  an
 >> architecture, a  philosophy, and a way  to defend a value  that is not
 >> important for you: Freedom.

 > I've got a shelf of OS texts, probably close to 90% of all the OS texts
 > written and I don't recall any of them teaching that you should take other
 > people's code, rename it, and claim it as your own in the name of freedom.

Stop lying. No one at the GNU project ever claimed a code to be his if
he didn't  write it. Just look in  any header file, and  you'll se the
copyright entries intact.  And we always say everywhere  that GNU Mach
is a fork of OSF Mach.

 >> > If the Hurd gets its drivers from Linux then it should rightfully be called
 >> > Linux/HURD (or Linux/HURD/GNU).
 >> 
 >> Stop trolling, thank you.

 > Hey, you want to spout nonsense then be prepared to be challenged.  I'm
 > just responding to something that is obviously incorrect, that's not
 > trolling, that's setting the record straight.  

You're just  writing a lot  of incorrect statements,  insulting people
(yes, you're  calling the GNU  project "thieves"), and  not correcting
anything, since you just answer completly outside the subject.

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org

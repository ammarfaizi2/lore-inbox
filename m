Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270351AbTGSR3l (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270377AbTGSR3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 13:29:41 -0400
Received: from smtp-106-saturday.nerim.net ([62.4.16.106]:43278 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S270351AbTGSR3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 13:29:38 -0400
To: Larry McVoy <lm@work.bitmover.com>
Cc: Christian Reichert <c.reichert@resolution.de>,
       John Bradford <john@grabjohn.com>, lkml@lrsehosting.com,
       linux-kernel@vger.kernel.org, lm@bitmover.com, rms@gnu.org,
       Valdis.Kletnieks@vt.edu
Subject: Re: [OT] HURD vs Linux/HURD
Mail-Copies-To: nobody
References: <200307191503.h6JF3tac002376@81-2-122-30.bradfords.org.uk>
	<1058626962.30424.6.camel@stargate>
	<plopm3lluu8mv0.fsf@drizzt.kilobug.org>
	<20030719172311.GA23246@work.bitmover.com>
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Sat, 19 Jul 2003 19:46:54 +0200
In-Reply-To: <20030719172311.GA23246@work.bitmover.com> (Larry McVoy's
 message of "Sat, 19 Jul 2003 10:23:11 -0700")
Message-ID: <plopm3he5i8l4h.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Larry!

Sat, 19 Jul 2003 10:23:11 -0700, you wrote: 

 >> - GNU/Hurd, the  whole systems, is  actually GNU tools  (libc, linker,
 >> ...)  on top  of the  GNU Hurd  (set of  servers) and  the  GNU Mach
 >> microkernel.

 > Mach wasn't written by GNU, it's a BSD based kernel

Totally wrong. You're confusing the  Mach operating system (with UX, a
BSD-server on top of the  Mach micro-kernel) and the Mach micro-kernel
itself.

> pried apart into chunks by people at CMU.

GNU Mach is  a modified version of OSF Mach  which is modified version
of CMU Mach.

 > Drivers and networking account for about 50% of the total lines of code.
 > The bulk of the work in any operating system is typically drivers.  The
 > generic part of Linux (non-driver, non-file system) is tiny compared to 
 > the rest.

Maybe  for  you,  an  OS  is  drivers.  For  me,  it's  a  design,  an
architecture, a  philosophy, and a way  to defend a value  that is not
important for you: Freedom.

 > If the Hurd gets its drivers from Linux then it should rightfully be called
 > Linux/HURD (or Linux/HURD/GNU).

Stop trolling, thank you.

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org

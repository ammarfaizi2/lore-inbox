Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289210AbSBMXoW>; Wed, 13 Feb 2002 18:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289186AbSBMXoI>; Wed, 13 Feb 2002 18:44:08 -0500
Received: from [63.231.122.81] ([63.231.122.81]:43305 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S289191AbSBMXnh>;
	Wed, 13 Feb 2002 18:43:37 -0500
Date: Wed, 13 Feb 2002 16:39:07 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Ben Greear <greearb@candelatech.com>
Cc: Bill Davidsen <davidsen@tmr.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020213163907.A16898@lynx.turbolabs.com>
Mail-Followup-To: Ben Greear <greearb@candelatech.com>,
	Bill Davidsen <davidsen@tmr.com>,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1020213180317.12448K-100000@gatekeeper.tmr.com> <3C6AF4F3.8080905@candelatech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C6AF4F3.8080905@candelatech.com>; from greearb@candelatech.com on Wed, Feb 13, 2002 at 04:21:23PM -0700
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13, 2002  16:21 -0700, Ben Greear wrote:
> Bill Davidsen wrote:
> > Did you build your mail reader with the sarcasm and hyperbole detector
> > option off?
> 
> And now how could he possibly know what options he built it
> with...or maybe it has it's .config in it somewhere? ;)

   $ mutt -v
   Mutt 1.2.5i (2000-07-28)
   Copyright (C) 1996-2000 Michael R. Elkins and others.
   Mutt comes with ABSOLUTELY NO WARRANTY; for details type `mutt -vv'.
   Mutt is free software, and you are welcome to redistribute it
   under certain conditions; type `mutt -vv' for details.

   System: Linux 2.4.17-pre8 [using slang 10402]
   Compile options:
   -DOMAIN
   -DEBUG
   -HOMESPOOL  -USE_SETGID  -USE_DOTLOCK  +USE_FCNTL  -USE_FLOCK
   +USE_IMAP  -USE_GSS  +USE_SSL  +USE_POP  +HAVE_REGCOMP  -USE_GNU_REGEX  
   +HAVE_COLOR  +HAVE_PGP  -BUFFY_SIZE -EXACT_ADDRESS  +ENABLE_NLS  +COMPRESSED
   SENDMAIL="/usr/sbin/sendmail"
   MAILPATH="/var/spool/mail"
   SHAREDIR="/usr/share/mutt"
   SYSCONFDIR="/etc"
   ISPELL="/usr/bin/ispell"
   To contact the developers, please mail to <mutt-dev@mutt.org>.
   To report a bug, please use the muttbug utility.

See, it's easy if the code supports it... ;-)

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131468AbRBJOsY>; Sat, 10 Feb 2001 09:48:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131469AbRBJOsP>; Sat, 10 Feb 2001 09:48:15 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62985 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131468AbRBJOsE>; Sat, 10 Feb 2001 09:48:04 -0500
Subject: Re: [reiserfs-list] Re: Apparent instability of reiserfs on 2.4.1
To: daniel@kabuki.eyep.net (Daniel Stone)
Date: Sat, 10 Feb 2001 14:47:25 +0000 (GMT)
Cc: mason@suse.com (Chris Mason), dbr@spoke.nols.com (David Rees),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org),
        reiserfs-list@namesys.com (reiserfs-list@namesys.com)
In-Reply-To: <E14QkfM-0004EL-00@piro.kabuki.eyep.net> from "Daniel Stone" at Feb 08, 2001 05:34:44 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14RbJG-0001ds-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I run Reiser on all but /boot, and it seems to enjoy corrupting my
> mbox'es randomly.
> Using the old-style Reiser FS format, 2.4.2-pre1, Evolution, on a CMD640
> chipset with the fixes enabled.
> This also occurs in some log files, but I put it down to syslogd
> crashing or something.

Before you put that down to reiserfs can you chek 2.4.2-pre2. It may be
problems below the reiserfs layer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

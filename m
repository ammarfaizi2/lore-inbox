Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270521AbTGSTuK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 15:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270522AbTGSTuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 15:50:09 -0400
Received: from smtp-106-saturday.noc.nerim.net ([62.4.17.106]:16911 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S270521AbTGSTuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 15:50:01 -0400
To: Larry McVoy <lm@work.bitmover.com>
Cc: Christoph Hellwig <hch@infradead.org>, Larry McVoy <lm@bitmover.com>,
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
	<20030719194123.A16317@infradead.org>
	<20030719184519.GB24197@work.bitmover.com>
From: kilobug@freesurf.fr (=?iso-8859-1?q?Ga=EBl_Le_Mignot?=)
Organization: HurdFr - http://hurdfr.org
X-PGP-Fingerprint: 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA
Date: Sat, 19 Jul 2003 22:07:16 +0200
In-Reply-To: <20030719184519.GB24197@work.bitmover.com> (Larry McVoy's
 message of "Sat, 19 Jul 2003 11:45:19 -0700")
Message-ID: <plopm34r1i8emj.fsf@drizzt.kilobug.org>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Mach is kinda on the bloated side, I always questioned the wisdom of
 > the GNU HURD being based on Mach, seemed like a bad call.  But then,
 > unless you have an extremely well controlled dev team, any micro kernel
 > is a bad call, it's going to bloat out.

If you  were documenting  yourself a bit  instead of  trolling, you'll
notice that's the GNU Hurd is not based on Mach. The GNU Hurd tries to
be micro-kernel independant, and will be ported to other microkernels,
like L4 Version 4.

And  if you  look a  bit  in the  history, you'll  notice that  second
generation  micro-kernels  (like  L4)  were  not  available,  or  even
designed, at the time Mach was chosen as the first microkernel to make
the Hurd runs on.

-- 
Gael Le Mignot "Kilobug" - kilobug@nerim.net - http://kilobug.free.fr
GSM         : 06.71.47.18.22 (in France)   ICQ UIN   : 7299959
Fingerprint : 1F2C 9804 7505 79DF 95E6 7323 B66B F67B 7103 C5DA

Member of HurdFr: http://hurdfr.org - The GNU Hurd: http://hurd.gnu.org

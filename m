Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbTAKE6O>; Fri, 10 Jan 2003 23:58:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267185AbTAKE6O>; Fri, 10 Jan 2003 23:58:14 -0500
Received: from FORT-POINT-STATION.MIT.EDU ([18.7.7.76]:52359 "EHLO
	fort-point-station.mit.edu") by vger.kernel.org with ESMTP
	id <S267184AbTAKE6O>; Fri, 10 Jan 2003 23:58:14 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Larry McVoy <lm@bitmover.com>
Subject: Re: Linus BK tree crashes with PANIC: INIT: segmentation violation
References: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
From: Derek Atkins <warlord@MIT.EDU>
Date: 11 Jan 2003 00:06:58 -0500
In-Reply-To: <Pine.LNX.4.44.0301101424590.1193-100000@penguin.transmeta.com>
Message-ID: <sjmwulc46ml.fsf@kikki.mit.edu>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok, I'll work on tracking down the exact patches where the changeovers
from 1->2 and 2->3 occur.  It's going to take me some time to
continually back out patches and rebuild, but I'll work on it.
Hopefully it will only take a couple days.

Any hints on ways to "move forward" as opposed to just moving
backwards would be useful too.

Thanks,

-derek

-- 
       Derek Atkins, SB '93 MIT EE, SM '95 MIT Media Laboratory
       Member, MIT Student Information Processing Board  (SIPB)
       URL: http://web.mit.edu/warlord/    PP-ASEL-IA     N1NWH
       warlord@MIT.EDU                        PGP key available

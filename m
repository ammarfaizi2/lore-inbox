Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129780AbRAFIYX>; Sat, 6 Jan 2001 03:24:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130018AbRAFIYO>; Sat, 6 Jan 2001 03:24:14 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:1387 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S129780AbRAFIYI>; Sat, 6 Jan 2001 03:24:08 -0500
Date: Sat, 6 Jan 2001 09:18:32 +0100
From: Christian Ullrich <chris@chrullrich.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Even slower NFS mounting with 2.4.0
Message-ID: <20010106091832.B557@christian.chrullrich.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010106002531.A490@christian.chrullrich.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010106002531.A490@christian.chrullrich.de>; from chris@chrullrich.de on Sat, Jan 06, 2001 at 12:25:31AM +0100
X-M$-Free-System: since 1999-11-28
X-Current-Uptime: 0 d, 00:11:07 h
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Ullrich wrote on Saturday, 2000-01-06:

> Using 2.2.18, every [NFS] mount took about 15 seconds, now, using 2.4.0,
> every mount takes exactly five minutes, which is way too long.

Ok, it's fixed now. Thanks to all of you, and especially the
(right now) three people who gave me the helpful hint 
to start the portmapper on the client as well.

l-k is great!

-- 
Christian Ullrich		     Registrierter Linux-User #125183

"Sie können nach R'ed'mond fliegen -- aber Sie werden sterben"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267858AbTBKRJ6>; Tue, 11 Feb 2003 12:09:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267833AbTBKRJ5>; Tue, 11 Feb 2003 12:09:57 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:643 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267858AbTBKRJ4>;
	Tue, 11 Feb 2003 12:09:56 -0500
Date: Tue, 11 Feb 2003 17:15:32 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 339] New: compile failure in drivers/char/watchdog/sc1200wdt.c
Message-ID: <20030211171532.GD20986@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20030211162307.GA20986@codemonkey.org.uk> <Pine.LNX.4.44.0302110907230.13587-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302110907230.13587-100000@home.transmeta.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 09:08:00AM -0800, Linus Torvalds wrote:
 
 > There currently currently isn't anything there that I can see..
 > 	torvalds@home:~/v2.5/linux> bk pull bk://linux-dj.bkbits.net/watchdog 
 > 	Nothing to pull from bk://linux-dj.bkbits.net/watchdog
 > 
 > Or am I just too fast?

Nope, I got trees mixed up, and forgot to push that to bkbits.
Its going up right now, should finish in the next few minutes.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281323AbRKEUlc>; Mon, 5 Nov 2001 15:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281318AbRKEUlW>; Mon, 5 Nov 2001 15:41:22 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:18704 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S281323AbRKEUlQ>; Mon, 5 Nov 2001 15:41:16 -0500
Date: Fri, 2 Nov 2001 12:25:25 +0000
From: Pavel Machek <pavel@suse.cz>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>, airlied@csn.ul.ie,
        linux-kernel@vger.kernel.org
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
Message-ID: <20011102122524.B45@toy.ucw.cz>
In-Reply-To: <Pine.GSO.4.21.0110302009430.3707-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0110301713130.19263-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.33.0110301713130.19263-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Oct 30, 2001 at 05:17:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> We used to have magic numbers for tty's and some other things, and they
> never helped anybody.

They are certainly helping me debugging swsusp.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


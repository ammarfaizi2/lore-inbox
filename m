Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280986AbRKGVKV>; Wed, 7 Nov 2001 16:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280985AbRKGVKL>; Wed, 7 Nov 2001 16:10:11 -0500
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:48647 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280982AbRKGVKA>; Wed, 7 Nov 2001 16:10:00 -0500
Date: Wed, 7 Nov 2001 01:20:09 +0000
From: Pavel Machek <pavel@suse.cz>
To: Tim Jansen <tim@tjansen.de>
Cc: =?iso-8859-1?Q?Jakob_=D8stergaard_?= <jakob@unthought.net>,
        linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011107012009.B35@toy.ucw.cz>
In-Reply-To: <E15zF9H-0000NL-00@wagner> <20011104172742Z16629-26013+37@humbolt.nl.linux.org> <20011104184159.E14001@unthought.net> <160RwJ-2D3EHoC@fmrl05.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <160RwJ-2D3EHoC@fmrl05.sul.t-online.com>; from tim@tjansen.de on Sun, Nov 04, 2001 at 07:27:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > It eats CPU, it's error-prone, and all in all it's just "wrong".
> 
> How much of your CPU time is spent parsing /proc files?

30% of 486 if you run top... That's way too much and top is unusable on slower
machines. 
"Not fast enough for showing processes" sounds wery wrong.
								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


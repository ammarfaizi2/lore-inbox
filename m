Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269178AbRHGWcY>; Tue, 7 Aug 2001 18:32:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269518AbRHGWcO>; Tue, 7 Aug 2001 18:32:14 -0400
Received: from alfik.ms.mff.cuni.cz ([195.113.19.71]:1039 "EHLO
	alfik.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S269515AbRHGWcD>; Tue, 7 Aug 2001 18:32:03 -0400
Date: Sun, 5 Aug 2001 22:19:37 +0000
From: Pavel Machek <pavel@suse.cz>
To: Dan Hollis <goemon@anime.net>
Cc: Jussi Laako <jlaako@pp.htv.fi>, linux-kernel@vger.kernel.org
Subject: CRC loop method (was Re: ReiserFS / 2.4.6 / Data Corruption)
Message-ID: <20010805221937.A78@toy.ucw.cz>
In-Reply-To: <3B672C6B.9AC418B0@pp.htv.fi> <Pine.LNX.4.30.0107311526360.13810-100000@anime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.LNX.4.30.0107311526360.13810-100000@anime.net>; from goemon@anime.net on Tue, Jul 31, 2001 at 03:32:39PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I'd be very happy with full data journalling even with 50% performance
> > penalty... There are applications that require extreme data integrity all
> > times no matter what happens.
> 
> How about an idea I proposed a while back, 'integrity loopback'?
> 
> A loopback device which writes a CRC with each block and checks the CRC
> when read back.

I have written that. Do you want a copy?

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.


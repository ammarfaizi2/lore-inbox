Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319660AbSIMOCr>; Fri, 13 Sep 2002 10:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319661AbSIMOCr>; Fri, 13 Sep 2002 10:02:47 -0400
Received: from dsl-213-023-022-092.arcor-ip.net ([213.23.22.92]:24206 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319660AbSIMOCq>;
	Fri, 13 Sep 2002 10:02:46 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Thunder from the hill <thunder@lightweight.ods.org>
Subject: Re: [RFC] Raceless module interface
Date: Fri, 13 Sep 2002 16:09:24 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Roman Zippel <zippel@linux-m68k.org>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Alexander Viro <viro@math.psu.edu>, <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0209130750270.10048-100000@hawkeye.luckynet.adm>
In-Reply-To: <Pine.LNX.4.44.0209130750270.10048-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17pr8P-00089M-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 September 2002 15:52, Thunder from the hill wrote:
> Hi,
> 
> On Fri, 13 Sep 2002, Daniel Phillips wrote:
> > On Friday 13 September 2002 08:51, Rusty Russell wrote:
> > > [cool code]
> > 
> > Why is that different from:
> > 
> > [more code]
> 
> Because in your example, my_module_start() would not be able to run 
> separately

That's obvious.  What hasn't been shown is why that's necessary.

Note: this is the *real* meaning of "begs the question".  You answered
my question "why is it necessary the these to be separate" with "because
if they were not separate, then you could not use them separately".  In
logical terms, it amounts to "A because A".  This is a logical falacy
called "begging the question".

When people say "begs the question", 99% of the time they really mean
"invites the question".  As an exercise, try scanning lkml for "From
includes Torvalds" and "begs".  Linus studied debating ;-)


-- 
Daniel

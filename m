Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266717AbUIEOZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266717AbUIEOZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 10:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266721AbUIEOZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 10:25:27 -0400
Received: from nysv.org ([213.157.66.145]:38601 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S266717AbUIEOZZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 10:25:25 -0400
Date: Sun, 5 Sep 2004 17:25:02 +0300
To: linux-kernel@vger.kernel.org
Subject: Re: Scheduler experiences
Message-ID: <20040905142502.GQ26192@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094386464.18114.0.camel@localhost>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Sandberg wrote:

>Hey, i wonder which scheduler you people have the best experiences with,
>staircase or nicksched?

I've been a fan of Staircase's for a long time; it simply responded faster
and launched progs faster.

I haven't tried nicksched in a while, but it didn't perform as well as
Staircase.

Having a batched mprime torture test in the background still allows me to
play a movie in mplayer, compile a kernel, listen to a CD and browse
the web without glitches. Not that I'd normally watch a movie and listen to
a CD at the same time ;)

Going to try Nicksched again RSN to see if it handles the same load, but
still I have to say I'm mighty pleased with Staircase and the rest of
Con's patches.

(Running 2.6.8.1-cko3 with the lenient patch of -ck6 at the moment)
(This is in an Athlon 1.3GHz with 512MB of RAM and roughly the same of swap)

-- 
mjt


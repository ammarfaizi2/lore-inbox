Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSIINcy>; Mon, 9 Sep 2002 09:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317326AbSIINcy>; Mon, 9 Sep 2002 09:32:54 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:46496 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S317308AbSIINcx>; Mon, 9 Sep 2002 09:32:53 -0400
Date: Mon, 9 Sep 2002 10:37:11 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Daniel Phillips <phillips@arcor.de>
cc: Andrew Morton <akpm@digeo.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: LMbench2.0 results
In-Reply-To: <E17oGD3-0006lS-00@starship>
Message-ID: <Pine.LNX.4.44L.0209091035470.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, Daniel Phillips wrote:

> I suspect the overall performance loss on the laptop has more to do with
> several months of focussing exclusively on the needs of 4-way and higher
> smp machines.

Probably true, we're pulling off an indecent number of tricks
for 4-way and 8-way SMP performance. This overhead shouldn't
be too bad on UP and 2-way machines, but might easily be a
percent or so.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org


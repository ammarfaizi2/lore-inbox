Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267102AbSK2QYP>; Fri, 29 Nov 2002 11:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267103AbSK2QYP>; Fri, 29 Nov 2002 11:24:15 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:11972 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267102AbSK2QYO>; Fri, 29 Nov 2002 11:24:14 -0500
Date: Fri, 29 Nov 2002 14:31:24 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Javier Marcet <jmarcet@pobox.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Exaggerated swap usage
In-Reply-To: <20021129115405.GD15682@jerry.marcet.dyndns.org>
Message-ID: <Pine.LNX.4.44L.0211291429260.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Nov 2002, Javier Marcet wrote:

> In recent 2.4.20 pre and rc kernels ( I tend to use the ac branch ), I
> had notice my system, when using X mainly, got terribly slow after some
> use.

First, lets get one thing straight:  the problem is the slowness,
not necessarily the swap usage.  It is very easy to jump to wrong
conclusions, so lets keep focussed on that part of the problem
which we know to be true before we all start hacking on parts of
the system which aren't related to the slowness...

> I can provide you with dmesg, /proc/meminfo or whatever might be useful.

How about some output (maybe 20 lines) of 'vmstat 1' during the
time where your system is slow, together with a short description
of how large the various processes (X, Mozilla ...) in your system
are ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261998AbSIPOgM>; Mon, 16 Sep 2002 10:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262012AbSIPOgM>; Mon, 16 Sep 2002 10:36:12 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:29897 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261998AbSIPOgM>; Mon, 16 Sep 2002 10:36:12 -0400
Date: Mon, 16 Sep 2002 11:40:36 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Frederik Nosi <fredi@e-salute.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: BENCHMARK - contest results
In-Reply-To: <200209161436.24243.fredi@e-salute.it>
Message-ID: <Pine.LNX.4.44L.0209161139580.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, Frederik Nosi wrote:

> 2.4.18-3  (RedHat kernel, booted without options)
> **************************************************
> noload          18:13.88                99%
> cpuload         21:36.64                83%
> ioload            28:22.85                63%
> memload       21:42.91                83%

This one has an (older) -rmap VM.

> 2.4.20-pre6  (Vanilla, booted with "vga=771")
> **************************************************
> noload         18:17.99                99%
> cpuload       21:51.48                81%
> ioload          30:28.49                58%
> memload      22:01.68                81%

And this is the vanilla VM.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbSKZQm5>; Tue, 26 Nov 2002 11:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266411AbSKZQm5>; Tue, 26 Nov 2002 11:42:57 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:57736 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266408AbSKZQm5>; Tue, 26 Nov 2002 11:42:57 -0500
Date: Tue, 26 Nov 2002 14:49:59 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Paul P Komkoff Jr <i@stingr.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [RFC] [CFT] rmap 15a for 2.4.20-rc2-ac3
In-Reply-To: <20021126163101.GL20701@stingr.net>
Message-ID: <Pine.LNX.4.44L.0211261447590.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Paul P Komkoff Jr wrote:

> The subject clearly described the patch.
>
> The only thing I'm unsure about is current->mm->... etc in
> kernel/sched.c

That code shouldn't be there at all. It's not in any of my rmap
patches and shouldn't be on bkbits.net either...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSIBNQC>; Mon, 2 Sep 2002 09:16:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSIBNQC>; Mon, 2 Sep 2002 09:16:02 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:33200 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318292AbSIBNQC>; Mon, 2 Sep 2002 09:16:02 -0400
Date: Mon, 2 Sep 2002 10:20:18 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
cc: Ed Sweetman <ed.sweetman@wmich.edu>, <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarks for performance patches (-ck) for 2.4.19
In-Reply-To: <20020902093910.G781@nightmaster.csn.tu-chemnitz.de>
Message-ID: <Pine.LNX.4.44L.0209021018440.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Sep 2002, Ingo Oeser wrote:

> This is not only X. The problem is the software layering bloat.
> Thats a design mistake we copied from W*ndows in our Linux
> applications.

Agreed, it is not just in one layer of the system.

However, changing the kernel _has_ resulted in a large
improvement in interactivity and does allow me to run
bonnie++ or even a 'bk clone' while playing mp3s and
without losing interactivity or having the mp3s skip...

On a machine with 192 MB RAM.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


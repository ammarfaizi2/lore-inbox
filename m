Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbSIPWTC>; Mon, 16 Sep 2002 18:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263221AbSIPWTC>; Mon, 16 Sep 2002 18:19:02 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:11191 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263218AbSIPWTA>; Mon, 16 Sep 2002 18:19:00 -0400
Date: Mon, 16 Sep 2002 19:23:46 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Cliff White <cliffw@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: contest v0.30 
In-Reply-To: <200209162157.g8GLvPO21115@mail.osdl.org>
Message-ID: <Pine.LNX.4.44L.0209161923100.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2002, Cliff White wrote:

> It looks neat, and i'd like to add it to the STP tests.
> I noticed you have hardcoded the '-j 4'
> Wouldn't it make more sense to adjust that to say, number_of_cpus * 2
> or something?

-j4 is nice for UP, since it sets the target CPU time for
the compile to 80% (with one background job).

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317593AbSGUANd>; Sat, 20 Jul 2002 20:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317598AbSGUANd>; Sat, 20 Jul 2002 20:13:33 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:29960 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317593AbSGUANc>; Sat, 20 Jul 2002 20:13:32 -0400
Date: Sat, 20 Jul 2002 21:12:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
       Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] VM strict overcommit
In-Reply-To: <Pine.LNX.4.44.0207201700360.2042-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44L.0207202110150.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jul 2002, Linus Torvalds wrote:

> Good. I hate the fact that so many people seem to think that adding 15
> lines of copyright notice to a file somehow makes it "more legal". All it
> does is to give some corporate lawyer a bone, and take up precious
> real-estate on the first thing you see when you open the file that could
> be used to actually say what the file does (and who has worked on it).

On a related note, it would be nice if files had a one-
(or two-)line description near the top saying what the
code in this file is supposed to do.

That should cut down on the time people spend searching the
kernel for code and maybe even reduce code duplication...

Would a series of small documentation patches adding small
descriptions to the top of files be welcome ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


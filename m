Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267612AbSKTC7p>; Tue, 19 Nov 2002 21:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267622AbSKTC7p>; Tue, 19 Nov 2002 21:59:45 -0500
Received: from 1-064.ctame701-1.telepar.net.br ([200.181.137.64]:5311 "EHLO
	1-064.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267612AbSKTC7o>; Tue, 19 Nov 2002 21:59:44 -0500
Date: Wed, 20 Nov 2002 01:06:39 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: David McIlwraith <quack@bigpond.net.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: spinlocks, the GPL, and binary-only modules
In-Reply-To: <024101c2903f$7650a050$41368490@archaic>
Message-ID: <Pine.LNX.4.44L.0211200105090.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002, David McIlwraith wrote:

> How should it? The compiler (specifically, the C preprocessor) includes
> the code, thus it is not the AUTHOR violating the GPL.

"Your honour, he didn't die because I shot him; he died
because he tried to catch the bullet, with his chest..."

If the compiler includes a .h file, it happens because
the programmer told it to do so, using a #include.

The programmer (or the copyright holder of the code) is
responsible.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


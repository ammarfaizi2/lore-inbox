Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750909AbVJXWLA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750909AbVJXWLA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 18:11:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbVJXWLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 18:11:00 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:43158 "EHLO smtp3-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750838AbVJXWK7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 18:10:59 -0400
To: linux-mips@linux-mips.org
Cc: linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Parallel port support for SGI O2
References: <871x2d3wyc.fsf@groumpf.homeip.net>
From: Arnaud Giersch <arnaud.giersch@free.fr>
X-Face: &yL?ZRfSIk3zaRm*dlb3R4f.8RM"~b/h|\wI]>pL)}]l$H>.Q3Qd3[<h!`K6mI=+cWpg-El
 B(FEm\EEdLdS{2l7,8\!RQ5aL0ZXlzzPKLxV/OQfrg/<t!FG>i.K[5isyT&2oBNdnvk`~y}vwPYL;R
 y)NYo"]T8NlX{nmIUEi\a$hozWm#0GCT'e'{5f@Rl"[g|I8<{By=R8R>bDe>W7)S0-8:b;ZKo~9K?'
 wq!G,MQ\eSt8g`)jeITEuig89NGmN^%1j>!*F8~kW(yfF7W[:bl>RT[`w3x-C
Date: Tue, 25 Oct 2005 00:10:57 +0200
In-Reply-To: <871x2d3wyc.fsf@groumpf.homeip.net> (Arnaud Giersch's message
 of "Sun, 23 Oct 2005 02:20:59 +0200")
Message-ID: <873bmq36ry.fsf@groumpf.homeip.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dimanche le 23 octobre 2005, vers 02:20:59 (CEST), j'ai écrit:

> I wrote a low-level parallel port driver for the built-in port on SGI
> O2 (a.k.a. IP32).
[...]
>   http://arnaud.giersch.free.fr/parport_ip32/parport_ip32-latest.patch.gz
>   http://arnaud.giersch.free.fr/parport_ip32.html

I uploaded a new version which fixes some bugs in FIFO transfer mode.

        Arnaud

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270536AbRHKCWb>; Fri, 10 Aug 2001 22:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270714AbRHKCWV>; Fri, 10 Aug 2001 22:22:21 -0400
Received: from zeus.kernel.org ([209.10.41.242]:40325 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S269793AbRHKCWC>;
	Fri, 10 Aug 2001 22:22:02 -0400
Date: Fri, 10 Aug 2001 22:13:46 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jeremy Linton <jlinton@interactivesi.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][PATCH] in sys_swapoff() path 
In-Reply-To: <Pine.LNX.4.33.0108101803570.1289-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0108102212360.3530-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001, Linus Torvalds wrote:

> Jeremy, Rik, please verify my changes..

It would be nice if you could leave in the comment
describing the SMP locking, otherwise we'd have to
figure out this stuff all over again during the 2.5
kernel.

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)



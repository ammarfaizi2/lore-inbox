Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266407AbSKZQiQ>; Tue, 26 Nov 2002 11:38:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266408AbSKZQiQ>; Tue, 26 Nov 2002 11:38:16 -0500
Received: from 5-106.ctame701-1.telepar.net.br ([200.193.163.106]:57990 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266407AbSKZQiP>; Tue, 26 Nov 2002 11:38:15 -0500
Date: Tue, 26 Nov 2002 14:45:12 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Patrick Finnegan <pat@purdueriots.com>
cc: Andi Kleen <ak@suse.de>, Jeff Dike <jdike@karaya.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: uml-patch-2.5.49-1
In-Reply-To: <Pine.LNX.4.44.0211260159440.7540-100000@ibm-ps850.purdueriots.com>
Message-ID: <Pine.LNX.4.44L.0211261443390.4103-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Nov 2002, Patrick Finnegan wrote:

> That's just one example... the idea is that you want maximal separation
> between the guest OS's apps and the host OS.  Sort of like "VM" on IBM's
> series of mainframe architecures.  [snip]

That's a nice idea, but in practice you also want efficient
execution of processes in the virtual machines and a virtual
host implementation that's flexible and easy to maintain.

As usual, you can't have everything so you'll have to make
choices here and there. The end result will be a useful
compromise between all the different ideas...

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>


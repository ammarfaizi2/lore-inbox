Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282747AbRLOPkD>; Sat, 15 Dec 2001 10:40:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282757AbRLOPjx>; Sat, 15 Dec 2001 10:39:53 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:62226 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S282747AbRLOPji>;
	Sat, 15 Dec 2001 10:39:38 -0500
Date: Sat, 15 Dec 2001 13:39:12 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Ingo Molnar <mingo@redhat.com>
Cc: Ben LaHaise <bcrl@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: mempool design
In-Reply-To: <Pine.LNX.4.33.0112150400440.14409-100000@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.33L.0112151337530.15741-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Dec 2001, Ingo Molnar wrote:

> such scenarios can only be solved by using/creating independent pools,
> and/or by using 'composite' pools like raid1.c does. One common

OK, you've convinced me ...
... of the fact that you're reinventing Ben's reservation
mechanism, poorly.

Please take a look at Ben's code. ;)

cheers,

Rik
-- 
Shortwave goes a long way:  irc.starchat.net  #swl

http://www.surriel.com/		http://distro.conectiva.com/


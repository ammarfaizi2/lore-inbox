Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269176AbRHDRUv>; Sat, 4 Aug 2001 13:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269801AbRHDRUm>; Sat, 4 Aug 2001 13:20:42 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:62226 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S269176AbRHDRUX>;
	Sat, 4 Aug 2001 13:20:23 -0400
Date: Sat, 4 Aug 2001 13:17:44 -0400
From: Anton Blanchard <anton@samba.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Andrew Tridgell <tridge@valinux.com>, lkml <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8preX VM problems
Message-ID: <20010804131744.A32213@krispykreme>
In-Reply-To: <Pine.LNX.4.21.0108040253030.9719-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0108040253030.9719-100000@freak.distro.conectiva>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > The patch below allowed us to get close to 4G of page cache before
> > things slowed down again and kswapd took over.
> 
> How much memory do you have on the box ?

It has 15G, so 512M of lowmem and 14.5G of highmem.

Anton

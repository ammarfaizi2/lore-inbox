Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbSL1NZG>; Sat, 28 Dec 2002 08:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbSL1NZF>; Sat, 28 Dec 2002 08:25:05 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:35028 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S264665AbSL1NZE>; Sat, 28 Dec 2002 08:25:04 -0500
Date: Sat, 28 Dec 2002 11:33:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Tomas Szepe <szepe@pinerecords.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Janet Morgan <janetmor@us.ibm.com>, "" <linux-scsi@vger.kernel.org>,
       "" <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
In-Reply-To: <20021228091608.GA13814@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
 <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com>
 <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>
 <20021228091608.GA13814@louise.pinerecords.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2002, Tomas Szepe wrote:

> Marcelo, you've been overlooking these updates for a bit too long now
> for your "let's throw them at -ac" to sound fair.  IMHO of course.  Also
> remember those are both production drivers tested thoroughly in FreeBSD,

Are we talking about the old or the new aic7xxx driver ?

If it's the new driver, it's breaking on WAY too many
machines and I have no idea why it got ever merged...

I have yet to see a machine where the new aic7xxx driver
works. I'm sure they exist, but it doesn't work on any
of the machines I have access to.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

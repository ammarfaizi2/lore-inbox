Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266297AbSL1TLW>; Sat, 28 Dec 2002 14:11:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266285AbSL1TLV>; Sat, 28 Dec 2002 14:11:21 -0500
Received: from 5-116.ctame701-1.telepar.net.br ([200.193.163.116]:35304 "EHLO
	5-116.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S266286AbSL1TLS>; Sat, 28 Dec 2002 14:11:18 -0500
Date: Sat, 28 Dec 2002 17:19:23 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       "" <linux-scsi@vger.kernel.org>, "" <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
In-Reply-To: <705128112.1041102818@aslan.scsiguy.com>
Message-ID: <Pine.LNX.4.50L.0212281718110.26879-100000@imladris.surriel.com>
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com>
 <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com>
 <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva>
 <20021228091608.GA13814@louise.pinerecords.com>
 <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>
 <705128112.1041102818@aslan.scsiguy.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Dec 2002, Justin T. Gibbs wrote:

> Unfortunately, the versions of the aic7xxx driver that are in the main
> trees (both nearly a year out of date) don't have this test and, like the
> "old" driver, they default to memory mapped I/O.  One of the reasons I've
> been pushing so hard for this new driver to go into the tree is that 90%
> of the complaints about the new driver would go away if it were updated
> to a sane revision.

Ohhhh, that would certainly explain.  Where could I get a patch
to update a recent 2.4 kernel to your latest aic7xxx driver ?

I'll happily test it on the machines where I have access...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

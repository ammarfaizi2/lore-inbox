Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267554AbSLSBuh>; Wed, 18 Dec 2002 20:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbSLSBuh>; Wed, 18 Dec 2002 20:50:37 -0500
Received: from 4-090.ctame701-1.telepar.net.br ([200.193.162.90]:35249 "EHLO
	4-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S267554AbSLSBuf>; Wed, 18 Dec 2002 20:50:35 -0500
Date: Wed, 18 Dec 2002 23:58:15 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>,
       "'Till Immanuel Patzschke'" <tip@inw.de>,
       lse-tech <lse-tech@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: 15000+ processes -- poor performance ?!
In-Reply-To: <1040265088.27221.7.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.50L.0212182357150.26879-100000@imladris.surriel.com>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA2C@orsmsx116.jf.intel.com>
 <1040265088.27221.7.camel@irongate.swansea.linux.org.uk>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Alan Cox wrote:

> He's running the -aa kernel, which has all the right bits for this too.
> In fact in some ways for very large memory boxes its probably the better
> variant

If you're willing to merge a patch to take -ac up to rmap15b
I'll integrate some large memory stuff into my tree for 15c
and 2.4-ac should be able to handle large boxes too within a
month or so.

(keeping the speed of merging slow, deliberately)

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269015AbTBWWp4>; Sun, 23 Feb 2003 17:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269016AbTBWWp4>; Sun, 23 Feb 2003 17:45:56 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:33664
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S269015AbTBWWpz>; Sun, 23 Feb 2003 17:45:55 -0500
Subject: Re: Minutes from Feb 21 LSE Call
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <16920000.1046033458@[10.10.2.4]>
References: <E18moa2-0005cP-00@w-gerrit2>
	 <Pine.LNX.4.44.0302222354310.8609-100000@dlang.diginsite.com>
	 <20030223082036.GI10411@holomorphy.com>
	 <b3b6oa$bsj$1@penguin.transmeta.com>
	 <1046031687.2140.32.camel@bip.localdomain.fake>
	 <16920000.1046033458@[10.10.2.4]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046044629.2210.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 23 Feb 2003 23:57:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-02-23 at 20:50, Martin J. Bligh wrote:
> >> And the baroque instruction encoding on the x86 is actually a _good_
> >> thing: it's a rather dense encoding, which means that you win on icache. 
> >> It's a bit hard to decode, but who cares? Existing chips do well at
> >> decoding, and thanks to the icache win they tend to perform better - and
> >> they load faster too (which is important - you can make your CPU have
> >> big caches, but _nothing_ saves you from the cold-cache costs). 
> > 
> > Next step: hardware gzip ?
> 
> They did that already ... IBM were demonstrating such a thing a couple of
> years ago. Don't see it helping with icache though, as it unpacks between
> memory and the processory, IIRC.

I saw the L2/L3 compressed cache thing, and I thought "doh!", and I watched and
I've not seen it for a long time. What happened to it ?


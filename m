Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263706AbUJ3Lix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263706AbUJ3Lix (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263707AbUJ3Lix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:38:53 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:8928 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S263706AbUJ3Lip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:38:45 -0400
Date: Sat, 30 Oct 2004 13:38:34 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Larry McVoy <lm@bitmover.com>
cc: Ram?n Rey Vicente <ramon.rey@hispalinux.es>,
       Xavier Bestel <xavier.bestel@free.fr>,
       James Bruce <bruce@andrew.cmu.edu>,
       Andrea Arcangeli <andrea@novell.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: BK kernel workflow
In-Reply-To: <20041029224100.GA7222@work.bitmover.com>
Message-ID: <Pine.LNX.4.61.0410301236390.877@scrub.home>
References: <Pine.LNX.4.58.0410251732500.427@ppc970.osdl.org>
 <Pine.LNX.4.61.0410270223080.877@scrub.home> <Pine.LNX.4.58.0410261931540.28839@ppc970.osdl.org>
 <4180B9E9.3070801@andrew.cmu.edu> <20041028135348.GA18099@work.bitmover.com>
 <1098972379.3109.24.camel@gonzales> <20041028151004.GA3934@work.bitmover.com>
 <41827B89.4070809@hispalinux.es> <20041029173642.GA5318@work.bitmover.com>
 <Pine.LNX.4.61.0410292132560.17266@scrub.home> <20041029224100.GA7222@work.bitmover.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 29 Oct 2004, Larry McVoy wrote:

> Roman, you can have any of your data that you want, including the metadata
> such as dates, times, user names, etc.  Nobody is hiding that from you,
> it's all there, you don't need a license to get it, go to bkbits.net and
> get it.

I had another closer look and it seems there are good chances to 
reconstruct the data in useable way (especially the rather recently 
added gnupatch and constant link should help). It's not my favourite 
solution, since it has to be pieced together from more parts than really 
necessary, but as proof of concept it should be interesting. So far I 
stayed away from this, because of the traffic this will cause and your 
previous disapproval of causing such traffic, but I can assure you I do my 
best to keep it to a minimum.

> > To make this easier to understand for everyone, here is a simple example: 
> > a very simple network protocol would be to extend the current commit mails 
> > with the identifiers one can already find in bkcvs, so they can be put 
> > into the correct order.
> 
> That's not a network protocol, just change the bloody commit trigger.
> I don't care if you get that information, if you want it, have at it.

I'm still a little confused how this matches your earlier statement, if 
you had said this earlier, we could have cut the whole thing short and I 
could have avoided getting roasted by Linus.
Anyway, I don't really care and thanks for the offer, I certainly will 
come back to it (although not immediately).

bye, Roman

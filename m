Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269667AbUJSTm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269667AbUJSTm7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 15:42:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267365AbUJSTmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 15:42:51 -0400
Received: from astound-64-85-224-245.ca.astound.net ([64.85.224.245]:17416
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S269738AbUJSTlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 15:41:50 -0400
Date: Tue, 19 Oct 2004 12:28:21 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: "Jeff V. Merkey" <jmerkey@drdos.com>
cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.9 and GPL Buyout
In-Reply-To: <417550FB.8020404@drdos.com>
Message-ID: <Pine.LNX.4.10.10410191225390.6975-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff,

I can ship you some hippie cabbage from Berkeley California if you are
fresh out of Peyote.

Cheers,

Andre

Andre Hedrick
LAD Storage Consulting Group

On Tue, 19 Oct 2004, Jeff V. Merkey wrote:

> Linus Torvalds wrote:
> 
> >Ok,
> > despite some naming confusion (expanation: I'm a retard), I did end up
> >doing the 2.6.9 release today. And it wasn't the same as the "-final" test
> >release (see explanation above).
> >
> >Excuses aside, not a lot of changes since -rc4 (which was the last
> >announced test-kernel), mainly some UML updates that don't affect anybody
> >else. And a number of one-liners or compiler fixes. Full list appended.
> >
> >		Linus
> >  
> >
> The memory sickness with disappearing buffers, and the BIO callback 
> problems with the
> SCSI layer previously reported appear to be corrected. This release is 
> very solid and
> withstands 400 MB/S I/O to disk from 3GB/1GB split kernel/user memory 
> configurations
> and does not have the disappearing memory problems I was experiencing 
> with massive
> BIO/skb I/O loading. The memory pressure being exerted is constant and 
> the kernel
> holds steady and stable enough for us to use and ship in our products 
> based on our
> testing of the 2.6.9 release over two days.
> 
> On a side note, the GPL buyout previously offered has been modified. We 
> will be contacting
> individual contributors and negotiating with each copyright holder for 
> the code we wish to
> convert on a case by case basis. The remaining portions of code will 
> remain GPL
> The 50K per copy offer still stands for the whole thing if you guys can 
> ever figure out
> how to set something like this up.
> :-)
> 
> Although we do not work with them and are in fact on the the other side 
> of Unixware from a
> competing viewpoint, SCO has contacted us and identifed with precise 
> detail and factual
> documentation the code and intellectual property in Linux they claim was 
> taken from Unix.
> We have reviewed their claims and they appear to create enough 
> uncertianty to warrant
> removal of the infringing portions.
> 
> We have identified and removed the infringing portions of Linux for our 
> products that
> SCO claims was stolen from Unix. They are:
> 
> JFS, XFS, All SMP support in Linux, and RCU.
> 
> They make claims of other portions of Linux which were taken, however, 
> these other claims
> do not appear to be supported with factual evidence.
> 
> Jeff
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


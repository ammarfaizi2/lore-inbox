Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316489AbSEOUhX>; Wed, 15 May 2002 16:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSEOUhW>; Wed, 15 May 2002 16:37:22 -0400
Received: from jffdns02.or.intel.com ([134.134.248.4]:43745 "EHLO
	hebe.or.intel.com") by vger.kernel.org with ESMTP
	id <S316489AbSEOUhU>; Wed, 15 May 2002 16:37:20 -0400
Message-ID: <D9223EB959A5D511A98F00508B68C20C0BFB7E81@orsmsx108.jf.intel.com>
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "'Stephen Hemminger'" <shemminger@osdl.org>,
        Pete Zaitcev <zaitcev@redhat.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Wed, 15 May 2002 13:37:02 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 2002-05-14 at 22:01, Pete Zaitcev wrote:
 
> The thing about Infiniband is that its scope is so great.
> If you consider Infiniband was only a glorified PCI with serial
> connector, the congestion control is not an issue. Credits
> are quite sufficient to provide per link flow control, and
> everything would work nicely with a couple of switches.
> Such was the original plan, anyways, but somehow cluster
> ninjas managed to hijack the spec and we have the rabid
> overengineering running amok. In fact, they ran so far
> that Intel jumped ship and created PCI Express, and we
> have discussions about congestion control. Sad, really...
> 


It's clear from this email thread that there is a lot of 
confusion about the intended use of InfiniBand and it's 
benefits. I'll take that as a need to prepare some material
for the Linux SymposiuM BOF that shows some of 
the  benefits of InfiniBand as demonstrated on the early
InfiniBand hardware. 




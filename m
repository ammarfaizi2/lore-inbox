Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130668AbRAaN5e>; Wed, 31 Jan 2001 08:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130660AbRAaN5O>; Wed, 31 Jan 2001 08:57:14 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:22791 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130526AbRAaN5K>; Wed, 31 Jan 2001 08:57:10 -0500
Subject: Re: IBM encryption chip support?
To: andre@linux-ide.org (Andre Hedrick)
Date: Wed, 31 Jan 2001 13:57:29 +0000 (GMT)
Cc: miles@megapath.net (Miles Lane), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101301028450.2518-100000@master.linux-ide.org> from "Andre Hedrick" at Jan 30, 2001 10:29:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14NxlL-0002Mf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 30 Jan 2001, Miles Lane wrote:
> 
> > Will this chip need any kernel support or
> > will it just need to be supported in usermode?
> > 
> > http://www.zdnet.com/zdnn/stories/news/0,4586,2680013,00.html?chkpt=zdnn_rt_latest
> 
> It looks like CPRM on the mainboard.........

Its certainly not a new idea. There are a wide number of trusted computing
situations where high speed public key crypto that is very hard to go around
the back of is a big win (think credit card data for one). 

Its also uninteresting for real security applications because nobody will
be prepared to assume that IBM silicon hasn't been tampered with by the NSA
and friends.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

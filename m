Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbTLALFV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 06:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbTLALFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 06:05:21 -0500
Received: from intra.cyclades.com ([64.186.161.6]:29839 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262827AbTLALFQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 06:05:16 -0500
Date: Mon, 1 Dec 2003 08:43:36 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Samuel Flory <sflory@rackable.com>, <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: libata in 2.4.24?
In-Reply-To: <Pine.LNX.4.44.0311292109340.1524-100000@logos.cnet>
Message-ID: <Pine.LNX.4.44.0312010836130.13692-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 29 Nov 2003, Marcelo Tosatti wrote:

> 
> 
> On Sat, 29 Nov 2003, Samuel Flory wrote:
> 
> >    Are you considering including libata support for 2.4.24?  From my 
> > testing with a number of different embedded sata chipsets (mostly ICH, 
> > SI, and Promise) it appears very stable.  I'm not seeing any data 
> > corruption or lockups when running Cerberus with 2.4.23-rc5 + libata 
> > patch.  The only troubles I've had were with initialization of embedded 
> > promise sata controllers. (I still need to test with Jeff's latest fixes 
> > for this.)
> 
> I'm happy to include it in 2.4 when Jeff thinks its stable enough for a 
> stable series. ;)

I thought a bit more about this issue and I have a different opinion now.

2.6 is getting more and more stable and already includes libata --- users 
who need it should use 2.6.




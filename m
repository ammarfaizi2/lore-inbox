Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932640AbVJ0VY3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932640AbVJ0VY3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:24:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbVJ0VY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:24:28 -0400
Received: from urchin.mweb.co.za ([196.2.24.26]:47296 "EHLO urchin.mweb.co.za")
	by vger.kernel.org with ESMTP id S932640AbVJ0VY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:24:27 -0400
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andi Kleen <ak@suse.de>
Subject: Re: <REAL> iBurst (TM) compatible driver
Date: Thu, 27 Oct 2005 23:25:20 +0200
User-Agent: KMail/1.8.92
Cc: "John W. Linville" <linville@tuxdriver.com>,
       Nicholas Jefferson <xanthophile@gmail.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <4cd031a50510270924r38ad4d5oa88ae92a514df3cf@mail.gmail.com> <20051027170727.GA26569@tuxdriver.com> <200510271944.12452.ak@suse.de>
In-Reply-To: <200510271944.12452.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510272325.20432.bonganilinux@mweb.co.za>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 October 2005 19:44, Andi Kleen wrote:
> On Thursday 27 October 2005 19:07, John W. Linville wrote:
> > On Fri, Oct 28, 2005 at 02:24:20AM +1000, Nicholas Jefferson wrote:
> > > The latest release of the iBurst (TM) compatible driver [1] for the
> > > 2.6 kernel is now available. Thanks to ArrayComm (R) for the original
> >
> > <snip>
> >
> > > Signed-off-by: Nicholas Jefferson <xanthophile@gmail.com>
> >
> > -ENOPATCH?
>
> And no description what an "iBurst (tm)" actually is. It sounds like
> something to clear blocked drains with.
>
> -Andi

iBurst is a wireless broadband internet service, so far I only know that it is 
available in Austrailer and South Africa. Here in South Africa, there are two 
devices you can use for connectivity an internal and external "modem". With 
the external modem, you can use either  USB or ethernet to connect (pppoe). 
The PCMCIA currently is not documented and there is no driver for Linux.

I ordered the external modem (still waiting for it), I'll try to get some guys 
from our LUG to test it (only the PCMCIA version is causing pain), hopefuly 
someone is stuck with that version ;)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbSKSQYh>; Tue, 19 Nov 2002 11:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbSKSQYg>; Tue, 19 Nov 2002 11:24:36 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:11535 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S266983AbSKSQYf>; Tue, 19 Nov 2002 11:24:35 -0500
Date: Tue, 19 Nov 2002 11:30:22 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Dan Kegel <dank@kegel.com>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, john slee <indigoid@higherplane.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why can't Johnny compile?
In-Reply-To: <1037661151.7486.44.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1021119112734.32451A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Nov 2002, Alan Cox wrote:

> 
> > OBSOLETE - the code in question provides either support for a no longer
> > easily available hardware, or better software to support the hardware (or
> > feature) is available. It does not mean that the feature is known not to
> > work, just that there are alternatives.
> 
> Currently (2.4) it means driver code which has not been updated to
> current kernel APIs

If we add a BROKEN category, would you agree that it is a more accurate
description of the status? I'm not asking that this be back-ported to 2.4,
but I think of OBSOLETE describing the nec pre-symbios drivers or similar
things. Or the aha152x driver which I still can't get going in 2.5 :-(

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


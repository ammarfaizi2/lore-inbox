Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319524AbSIGViM>; Sat, 7 Sep 2002 17:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319525AbSIGViM>; Sat, 7 Sep 2002 17:38:12 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:3568 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319524AbSIGViL>; Sat, 7 Sep 2002 17:38:11 -0400
Subject: Re: LMbench2.0 results
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Paolo Ciarrocchi <ciarrocchi@linuxmail.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0209071553020.1857-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0209071553020.1857-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-6) 
Date: 07 Sep 2002 22:44:30 +0100
Message-Id: <1031435070.14390.14.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-07 at 19:53, Rik van Riel wrote:
> On Sat, 7 Sep 2002, Jeff Garzik wrote:
> > Paolo Ciarrocchi wrote:
> > > Comments?
> >
> > Yeah:  "ouch" because I don't see a single category that's faster.
> 
> HZ went to 1000, which should help multimedia latencies a lot.

It shouldn't materially damage performance unless we have other things
extremely wrong. Its easy enough to verify by putting HZ back to 100 and
rebenching 



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290350AbSAXVvW>; Thu, 24 Jan 2002 16:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290347AbSAXVvO>; Thu, 24 Jan 2002 16:51:14 -0500
Received: from waste.org ([209.173.204.2]:30377 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S290350AbSAXVvA>;
	Thu, 24 Jan 2002 16:51:00 -0500
Date: Thu, 24 Jan 2002 15:50:48 -0600 (CST)
From: Oliver Xymoron <oxymoron@waste.org>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <200201242141.g0OLfjL06681@home.ashavan.org.>
Message-ID: <Pine.LNX.4.44.0201241545120.2839-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jan 2002, Timothy Covell wrote:

> > > I thought that the whole point of booleans was to stop silly errors
> > > like
> > >
> > > if ( x = 1 )
> > > {
> > > 	printf ("\nX is true\n");
> > > }
> > And how does s/1/true/ fix that?
>
> It doesn't fix  "if ( x = true)". If would
> just make it more legit to use "if (x)".

It's been legit and idiomatic since day 1, if not sooner.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290422AbSAXWgx>; Thu, 24 Jan 2002 17:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290424AbSAXWgs>; Thu, 24 Jan 2002 17:36:48 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:3007 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S290422AbSAXWgH>;
	Thu, 24 Jan 2002 17:36:07 -0500
Date: Thu, 24 Jan 2002 17:36:04 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Timothy Covell <timothy.covell@ashavan.org>
cc: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <200201242228.g0OMSlL06826@home.ashavan.org.>
Message-ID: <Pine.GSO.4.21.0201241735280.21209-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 25 Jan 2002, Timothy Covell wrote:

> What about 
> 
> {
>     char x;
> 
>     if ( x )
>     {
>         printf ("\n We got here\n");
>     }
>     else
>     {
>         // We never get here
>         printf ("\n We never got here\n");
>     }
> }

What???  Learn the fscking C.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265132AbSKVR4C>; Fri, 22 Nov 2002 12:56:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265135AbSKVR4C>; Fri, 22 Nov 2002 12:56:02 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:31961 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S265132AbSKVR4B>; Fri, 22 Nov 2002 12:56:01 -0500
Date: Fri, 22 Nov 2002 12:05:15 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: e1000 fixes (NAPI)
Message-ID: <20021122120515.A5105@vger.timpanogas.org>
References: <15838.1306.900100.541977@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15838.1306.900100.541977@robur.slu.se>; from Robert.Olsson@data.slu.se on Fri, Nov 22, 2002 at 11:21:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'll check it out.

:-)

Jeff

On Fri, Nov 22, 2002 at 11:21:14AM +0100, Robert Olsson wrote:
> 
> 
> 
> Seems like FreeBSD is now getting on this train too. Someone sent me this link.
> http://info.iet.unipi.it/~luigi/polling/
> 
> Cheers.
> 
> 						--ro
> 
> 
> Jeff V. Merkey writes:
>  > 
>  > Thanks
>  > 
>  > jeff
>  > 
>  > On Thu, Nov 21, 2002 at 12:31:08PM -0500, Jeff Garzik wrote:
>  > > Jeff V. Merkey wrote:
>  > > 
>  > > > >NAPI poll does not happen in an interrupt.  Doing things in interrupts
>  > > > >is the source of problems that NAPI is trying to solve.
>  > > > >
>  > > > >Other than that, please read the code and NAPI paper...  :)
>  > > >
>  > > >
>  > > >
>  > > >
>  > > > Where can I find it?
>  > > 
>  > > 
>  > > 
>  > > In the link Robert Ollson gave to you (paper), and the Linux kernel (code).
>  > > 
>  > > 	Jeff
>  > > 
>  > > 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

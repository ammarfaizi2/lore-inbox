Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSECAFc>; Thu, 2 May 2002 20:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315480AbSECAEf>; Thu, 2 May 2002 20:04:35 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48903
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S315484AbSECADh>; Thu, 2 May 2002 20:03:37 -0400
Date: Thu, 2 May 2002 17:02:49 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Kjartan Maraas <kmaraas@online.no>
cc: Samuel Flory <sflory@rackable.com>, linux-kernel@vger.kernel.org,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.4.19pres and IDE DMA
In-Reply-To: <1020374480.3134.1.camel@sevilla.gnome.no>
Message-ID: <Pine.LNX.4.10.10205021702030.2107-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kjartan,

You used a beta that has been I made general and not specific, but I broke
it :-(.

On 2 May 2002, Kjartan Maraas wrote:

> tor, 2002-05-02 kl. 22:41 skrev Samuel Flory:
> >   I'm having issues with a Tyan 2720 and post 2.4.18 boards with a 
> > Maxtor 4G120J6.  Under 2.4.18 I can turn on dma via "hdparm -d 1". 
> >  Under 2.4.19pre7 I get "HDIO_SET_DMA fail ed: Operation not permitted". 
> >  On a side note the same thing occurs with the RH 2.4.18-0.13 kernel. 
> >  It appears both kernels merged an ide update from the ac kernel line.
> > 
> > PS-There is also some issue with a resource conflict that occurs under 
> > every kernel I've tried.
> 
> I had the exact same problem myself with a brand new Compaq N600c
> laptop. It was fixed for me by using Andre's patch from
> http://linuxdiskcert.org/
> 
> Cheers
> Kjartan
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group


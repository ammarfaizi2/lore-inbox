Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268472AbTANBiL>; Mon, 13 Jan 2003 20:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268473AbTANBiL>; Mon, 13 Jan 2003 20:38:11 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:6 "EHLO
	master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S268472AbTANBiK>; Mon, 13 Jan 2003 20:38:10 -0500
Date: Mon, 13 Jan 2003 17:44:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ross Biro <rossb@google.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4
In-Reply-To: <3E23696A.9040006@google.com>
Message-ID: <Pine.LNX.4.10.10301131743340.18906-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ross,

Is wonderful how you can not say who the vendor is who is violating the
spec.  *sigh*

On Mon, 13 Jan 2003, Ross Biro wrote:

> Ross Biro wrote:
> 
> >>>
> >>> This is technically a spec violation, but it's probably safe.  I'm 
> >>> going to send an email to a couple of the drive manufacturers and 
> >>> see what they think.
> >>>   
> >>
> I just heard back from one ide controller chip vendor and they think we 
> should disable PCI write posting.  From the tone of the response, I 
> believe that they may not have thought of this before and it may be a 
> problem in their non-opensource drivers as well.
> 
>     Ross
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

Andre Hedrick
LAD Storage Consulting Group


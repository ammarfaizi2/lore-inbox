Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319318AbSH2T1s>; Thu, 29 Aug 2002 15:27:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319319AbSH2T1r>; Thu, 29 Aug 2002 15:27:47 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:36368 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S319318AbSH2T1r>; Thu, 29 Aug 2002 15:27:47 -0400
Date: Thu, 29 Aug 2002 14:32:10 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andre Hedrick <andre@linux-ide.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.20-pre4-ac1 trashed my system
In-Reply-To: <1030649283.7290.168.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208291427220.13200-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 Aug 2002, Alan Cox wrote:

> 
> PIO LBA48 seems to work on all promise
> Early promise needs a helping hand with DMA LBA48, one promise doesnt
> seem to do DMA LBA48 on secondary at all, and newer stuff gets it right.
>  
> 
> And what controller/drives which you've provided.

Another detail: The drive was on the primary cable, configured as
master.  It came up as /dev/hde (because hd[a-d] was for the
motherboard's "native" controller).


> 
> If you can replicate it and find out where the problem begins that would
> be wonderful in itself.
> 

I'll do what I can.  I never have enough time.  However I've benefitted
from this excellent OS for too long; I should be doing more in return.

  -Mike


                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313711AbSELRgM>; Sun, 12 May 2002 13:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313904AbSELRgL>; Sun, 12 May 2002 13:36:11 -0400
Received: from ns1.system-techniques.com ([199.33.245.254]:36762 "EHLO
	filesrv1.baby-dragons.com") by vger.kernel.org with ESMTP
	id <S313711AbSELRgK>; Sun, 12 May 2002 13:36:10 -0400
Date: Sun, 12 May 2002 13:36:00 -0400 (EDT)
From: "Mr. James W. Laferriere" <babydr@baby-dragons.com>
To: john slee <indigoid@higherplane.net>
cc: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Tcp/ip offload card driver
In-Reply-To: <20020512005537.GG3855@higherplane.net>
Message-ID: <Pine.LNX.4.44.0205121335050.14675-100000@filesrv1.baby-dragons.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello John ,  Think about it ;-) .  Maybe an order of magnitude ?
		JimL

On Sun, 12 May 2002, john slee wrote:
> On Fri, May 10, 2002 at 10:51:06AM -0500, Nicholas Harring wrote:
> > And how about when an SMP system isn't enough? Should I have to
> > re-engineer my network storage architecture when hardware exists that'll
> > increase throughput if a simple device driver gets written? Don't forget
> > that with 64 bit PCI that the limit of the bus has been raised, and with
>
> jeff merkey has already demonstrated 300MiB/sec and higher speeds on x86
> linux, with 3ware raid and dolphin sci cards.  how much faster do you
> need to go?
>
> j.
>
> --
> R N G G   "Well, there it goes again... And we just sit
>  I G G G   here without opposable thumbs." -- gary larson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

       +------------------------------------------------------------------+
       | James   W.   Laferriere | System    Techniques | Give me VMS     |
       | Network        Engineer |     P.O. Box 854     |  Give me Linux  |
       | babydr@baby-dragons.com | Coudersport PA 16915 |   only  on  AXP |
       +------------------------------------------------------------------+


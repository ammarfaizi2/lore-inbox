Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129429AbQLDSBu>; Mon, 4 Dec 2000 13:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129465AbQLDSBk>; Mon, 4 Dec 2000 13:01:40 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:29191
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S129429AbQLDSBX>; Mon, 4 Dec 2000 13:01:23 -0500
Date: Mon, 4 Dec 2000 09:30:20 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Guennadi Liakhovetski <gvlyakh@mail.ru>
cc: linux-kernel@vger.kernel.org, Mike Dresser <mdresser@windsormachine.com>
Subject: Re: Re[2]: DMA !NOT ONLY! for triton again...
In-Reply-To: <E142zJP-000Mbh-00@f3.mail.ru>
Message-ID: <Pine.LNX.4.10.10012040927490.13699-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Guennadi,

I have watched this and even if UDMA is not supported cleanly by the
drive, the classic ATA-2 Multi-wrod DMA should be.  There was a time in
the past where WDC had some problems, but they have fixed most if not all
with "modern" drives.  I will be at WDC in two weeks, and I can raise the
issues with them.  Please spell them out completely.

Regards,

On Mon, 4 Dec 2000, Guennadi Liakhovetski wrote:

> Well, yes, I thought they could not have known:-)) I'm absolutely stuck. If disk is fine, chipset is fine and supported by the kernel, then BIOS doesn't (or shouldn't) make a difference... Then WHAT ON THE EARTH??? Mike, have you been able to recall what BIOS option turned DMA on? Shall I write to Andre Hedrick directly? Or is there a mailing-list smth. like linux-ide?
> 
> > Now, the question is, can we trust a hard drive manufacturer
> > support tech to know what they're talking about, with evidence to
> > the contrary? :)
> 
> Thanks
> Guennadi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

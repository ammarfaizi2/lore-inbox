Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbQKQTnK>; Fri, 17 Nov 2000 14:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130441AbQKQTnA>; Fri, 17 Nov 2000 14:43:00 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:12551
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130344AbQKQTmv>; Fri, 17 Nov 2000 14:42:51 -0500
Date: Fri, 17 Nov 2000 11:12:33 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: sorted - was: How to add a drive to DMA black list?
In-Reply-To: <E13wjAz-0000Uy-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10011171110540.9796-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Nov 2000, Alan Cox wrote:

> > Then I need to fix that to prevent the bypass that should not happen.
> 
> No you need to fix the PIIX tuning hangs people keep reporting 8)

You can't fix was the docs claim is broken and issuing a channel reset is
the only way out.  Unfortunate, this is what I am looking at doing :-((

Cheers,

Andre Hedrick
CTO Timpanogas Research Group
EVP Linux Development, TRG
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

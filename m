Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131168AbQLRJf4>; Mon, 18 Dec 2000 04:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131066AbQLRJfq>; Mon, 18 Dec 2000 04:35:46 -0500
Received: from virtualro.ic.ro ([194.102.78.138]:20235 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S130835AbQLRJfc>;
	Mon, 18 Dec 2000 04:35:32 -0500
Date: Mon, 18 Dec 2000 11:04:51 +0200 (EET)
From: Jani Monoses <jani@virtualro.ic.ro>
To: Simon Huggins <huggie@earth.li>
cc: linux-kernel@vger.kernel.org
Subject: Re: kernel-doc minor fix
In-Reply-To: <20001217172237.F1301@paranoidfreak.freeserve.co.uk>
Message-ID: <Pine.LNX.4.10.10012181102410.13641-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 17 Dec 2000, Simon Huggins wrote:

> On Sat, Dec 16, 2000 at 04:41:44PM +0200, Jani Monoses wrote:
> > +    $prototype =~ s/^const+ //;
> Yours confusedly,
> 
> Simon.

Hi 

I can't answer to your question but this patch is not good anyway as Tim
pointed out to me.


Jani.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

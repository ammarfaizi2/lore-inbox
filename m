Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129664AbQKQT3Q>; Fri, 17 Nov 2000 14:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130594AbQKQT3G>; Fri, 17 Nov 2000 14:29:06 -0500
Received: from mhaaksma-3.dsl.speakeasy.net ([64.81.17.226]:55051 "EHLO
	mail.neruo.com") by vger.kernel.org with ESMTP id <S129664AbQKQT2z>;
	Fri, 17 Nov 2000 14:28:55 -0500
Subject: Re: APM oops with Dell 5000e laptop
From: Brad Douglas <brad@neruo.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: alan@lxorguk.ukuu.org.uk, dax@gurulabs.com, linux-kernel@vger.kernel.org
In-Reply-To: <E13wj4s-0000U0-00@the-village.bc.nu>
Content-Type: text/plain
X-Mailer: Evolution 0.6 (Developer Preview)
Date: 18 Nov 2000 02:57:16 +0800
Mime-Version: 1.0
Message-Id: <20001117192856Z129664-28370+57@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I don't believe doing this just to make a Dell detect properly is the right way to go (regardless of my bias).  I think the best we can do build a list of the systems that are the same, but it's certainly not a preferred way.
> > 
> > Any suggestions?
> 
> The ideal approach is to ident and version id the compal bios. The DMI tables
> can include more useful BIOS info but rarely do (you might want to dump all the
> DMI tables in your box and see if you have a BIOS vendor/version)

The BIOS revisions seem to match up, but there are already multiple versions of the BIOS for this machine already, so I initially discounted that method.  It also means a bit of upkeep, too.
I was really hoping for a "set it and forget it" approach, but that doesn't seem possible.

Brad Douglas
brad@neruo.com
brad@tuxtops.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

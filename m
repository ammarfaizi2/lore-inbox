Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143762AbRA1SkV>; Sun, 28 Jan 2001 13:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143800AbRA1SkL>; Sun, 28 Jan 2001 13:40:11 -0500
Received: from shell.cyberus.ca ([209.195.95.7]:694 "EHLO shell.cyberus.ca")
	by vger.kernel.org with ESMTP id <S143762AbRA1Sj5>;
	Sun, 28 Jan 2001 13:39:57 -0500
Date: Sun, 28 Jan 2001 13:38:55 -0500 (EST)
From: jamal <hadi@cyberus.ca>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: James Sutherland <jas88@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: ECN: Clearing the air (fwd)
In-Reply-To: <200101281823.TAA06080@cave.bitwizard.nl>
Message-ID: <Pine.GSO.4.30.0101281335350.24762-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 28 Jan 2001, Rogier Wolff wrote:

> > This would have been easier. The firewall operators were not
> > provided with this option. This is hard-coded. I agree with the rest
> > of your message.
>
> Take "configure" with a bit of liberty. Because the firewall vendor
> chose to hard-code this into the firmware. "configuring" in this case
> means reconfiguring new software on the firewall. Blame the vendor.

Perhaps the most famous writting on protocol design was by Jon Postel.
Interestingly in RFC 793 (Section 2.10)
" be conservative in what you do, be liberal in what you accept from
  others."

That should be the mantra.
There is no librety when you hard-code.

cheers,
jamal

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

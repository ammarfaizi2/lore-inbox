Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129327AbQKAPUT>; Wed, 1 Nov 2000 10:20:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130119AbQKAPUA>; Wed, 1 Nov 2000 10:20:00 -0500
Received: from [62.172.234.2] ([62.172.234.2]:23603 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129327AbQKAPTx>;
	Wed, 1 Nov 2000 10:19:53 -0500
Date: Wed, 1 Nov 2000 15:19:37 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Roesen <dr@bofh.de>, richard.schaal@intel.com, mikpe@csd.uu.se,
        simon@veritas.com
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <E13qzOG-0000TG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011011516190.4466-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Alan Cox wrote:

> > for microcode update as family=6? The manuals suggest that test for ">" is
> > correct, i.e. that Intel will maintain compatibility with P6 wrt microcode
> > update.
> > 
> > Perhaps Richard can clarify this?
> 
> Until we know what the preventium IV does on microcode behaviour it seems
> wisest to test for == not >.

Ok, true, I agree with both you and Mikael Pettersson. Also, I couldn't
find where in the volumeIII I saw references to ">", perhaps it wasn't in
the docs but just in some sample Intel implementation (or maybe not).

Regards,
Tigran



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

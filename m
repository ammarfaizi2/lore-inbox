Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130357AbQKSGDX>; Sun, 19 Nov 2000 01:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130293AbQKSGDC>; Sun, 19 Nov 2000 01:03:02 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:20007 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129588AbQKSGCw>; Sun, 19 Nov 2000 01:02:52 -0500
Message-ID: <3A1765D6.C1E45E36@linux.com>
Date: Sat, 18 Nov 2000 21:32:09 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, David Hinds <dhinds@valinux.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia event thread. (fwd)
In-Reply-To: <Pine.LNX.4.10.10011180750230.8465-100000@penguin.transmeta.com>
Content-Type: multipart/mixed;
 boundary="------------15E3F3B023772932B7E6FBBB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------15E3F3B023772932B7E6FBBB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:

> Can you (you've probably done this before, but anyway) enable DEBUG in
> arch/i386/kernel/pci-i386.h? I wonder if the kernel for some strange
> reason doesn't find your router, even though "dump_pirq" obviously does..
> If there's something wrong with the checksumming for example..

..building now.

-d


--------------15E3F3B023772932B7E6FBBB
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;14688
fn:David Ford
end:vcard

--------------15E3F3B023772932B7E6FBBB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129667AbQKGAkQ>; Mon, 6 Nov 2000 19:40:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130684AbQKGAkG>; Mon, 6 Nov 2000 19:40:06 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:57985 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130682AbQKGAjy>; Mon, 6 Nov 2000 19:39:54 -0500
Message-ID: <3A074F4F.DACD7ABA@linux.com>
Date: Mon, 06 Nov 2000 16:39:43 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Hinds <dhinds@valinux.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: current snapshots of pcmcia
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com> <3A073C8D.B6511746@linux.com> <20001106154039.A19860@valinux.com> <3A074AAC.1F88DB3@linux.com> <20001106163154.A20457@valinux.com>
Content-Type: multipart/mixed;
 boundary="------------3F3F472F6373038A4BE1B8E8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3F3F472F6373038A4BE1B8E8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

David Hinds wrote:

> Incidentally, the i82365 module should work ok (using ISA interrupts)
> despite the "No IRQ known" messages.  The Yenta driver won't work at
> all if PCI interrupts aren't set up.  So I guess another question
> would be, what card(s) are you using and how are they misbehaving?

I'm using tulip based cards and a linksys PC 10/100 + 56K mdm.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------3F3F472F6373038A4BE1B8E8
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

--------------3F3F472F6373038A4BE1B8E8--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

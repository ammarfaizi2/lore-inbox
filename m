Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131169AbQKCVFX>; Fri, 3 Nov 2000 16:05:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131405AbQKCVFN>; Fri, 3 Nov 2000 16:05:13 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:36521 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S131169AbQKCVFD>; Fri, 3 Nov 2000 16:05:03 -0500
Message-ID: <3A032828.6B57611F@linux.com>
Date: Fri, 03 Nov 2000 13:03:36 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.org>
CC: tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------76A60DB3201A3D1D36BEC6EC"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------76A60DB3201A3D1D36BEC6EC
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> > 10. To Do But Non Showstopper
> >      * PCMCIA/Cardbus hangs (Basically unusable - Hinds pcmcia code is
> >        reliable)
> >           + PCMCIA crashes on unloading pci_socket
>
> The pci_socket crash is fixed it seems

Not unless it was fixed in test10 release.  I have a PC LinkSys dual 10/100 and
56K card that will kill the machine if you physically pull it out no matter what
cardctl/module steps are taken.

It uses the ne2k and serial drivers.

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------76A60DB3201A3D1D36BEC6EC
Content-Type: text/x-vcard; charset=us-ascii;
 name="david.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for David Ford
Content-Disposition: attachment;
 filename="david.vcf"

begin:vcard 
n:Ford;David
x-mozilla-html:TRUE
org:<img src="http://www.kalifornia.com/images/paradise.jpg">
adr:;;;;;;
version:2.1
email;internet:david@kalifornia.com
title:Blue Labs Developer
x-mozilla-cpt:;-12480
fn:David Ford
end:vcard

--------------76A60DB3201A3D1D36BEC6EC--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

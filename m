Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129254AbQKCV5a>; Fri, 3 Nov 2000 16:57:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129353AbQKCV5T>; Fri, 3 Nov 2000 16:57:19 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:34474 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129254AbQKCV5O>; Fri, 3 Nov 2000 16:57:14 -0500
Message-ID: <3A03335F.8E2B71B5@linux.com>
Date: Fri, 03 Nov 2000 13:51:27 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>, Alan Cox <alan@redhat.org>,
        tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rj9s-0003c4-00@the-village.bc.nu> <3A032828.6B57611F@linux.com> <3A0329DA.38A90824@mandrakesoft.com>
Content-Type: multipart/mixed;
 boundary="------------18232B2D94859A1D8BBC1617"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------18232B2D94859A1D8BBC1617
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The odd part is that it used to work "way back when".  Was this just a fluke?

-d

Jeff Garzik wrote:

> > Not unless it was fixed in test10 release.  I have a PC LinkSys dual 10/100 and
> > 56K card that will kill the machine if you physically pull it out no matter what
> > cardctl/module steps are taken.
> >
> > It uses the ne2k and serial drivers.
>
> Part of that might be that serial doesn't support hotplug without
> patching.

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------18232B2D94859A1D8BBC1617
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

--------------18232B2D94859A1D8BBC1617--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

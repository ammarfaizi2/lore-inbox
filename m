Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130037AbQKDCj4>; Fri, 3 Nov 2000 21:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130847AbQKDCjq>; Fri, 3 Nov 2000 21:39:46 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:11691 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S130037AbQKDCjd>; Fri, 3 Nov 2000 21:39:33 -0500
Message-ID: <3A037679.E96C5E30@linux.com>
Date: Fri, 03 Nov 2000 18:37:45 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.org>
CC: Jeff Garzik <jgarzik@mandrakesoft.com>, tytso@mit.edu,
        linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 Status / TODO page (Updated as of 2.4.0-test10)
In-Reply-To: <E13rqz1-00046G-00@the-village.bc.nu>
Content-Type: multipart/mixed;
 boundary="------------2B17EF66ACF25B283D794010"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2B17EF66ACF25B283D794010
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Alan Cox wrote:

> > > Not unless it was fixed in test10 release.  I have a PC LinkSys dual 10/100 and
> > > 56K card that will kill the machine if you physically pull it out no matter what
> Linksys rings a bell with an outstandng 2.2 lockup on pcmcia. I think this might
> be a driver bug ?

I suspect it might be, I also think it may be getting the wrong voltage or it's poorly
designed hardware.  It gets hot enough to make a blister if you don't handle it
carefully.

It works fine all the while installed, goes for days on end, even tho it gets
incredibly hot. :)

-d

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------2B17EF66ACF25B283D794010
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

--------------2B17EF66ACF25B283D794010--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129044AbQKIBQn>; Wed, 8 Nov 2000 20:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129582AbQKIBQd>; Wed, 8 Nov 2000 20:16:33 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:61479 "EHLO
	nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S129147AbQKIBQT>; Wed, 8 Nov 2000 20:16:19 -0500
Message-ID: <3A09FACF.9334A299@linux.com>
Date: Wed, 08 Nov 2000 17:15:59 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Brett <bpemberton@dingoblue.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: pcmcia
In-Reply-To: <Pine.LNX.4.21.0011091131240.9217-100000@tae-bo.generica.dyndns.org>
Content-Type: multipart/mixed;
 boundary="------------912B6B0C5FC30388558993BB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------912B6B0C5FC30388558993BB
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

You may be in the same boat I'm in then.  i82365 is what I used and it worked.
yenta doesn't.  Right now I'm stuck with using my USB nic because neither the
kernel's pcmcia or dh pcmcia work for me.

-d

Brett wrote:

> Hey,
>
> I don't know if this counts as a _problem_,
> but I need to enable pci support to get pcmcia/cardbus activated.
> Is this really necessary ?? My current kernels work fine without pci
> support, and sure, enabling it won't hurt, just make the kernel bigger,
> but why is the restriction there ?
>
> Also, what has happened to the i82365 support that I need ?
> Its nicely commented out in drivers/net/pcmcia/Config.in
>
> I remember everything working fine up until about test3/4, since then I've
> had to revert to the pcmcia-cs package.
>
> Just wondering whats going on ?
>
>         / Brett
>
> On Wed, 8 Nov 2000, David Ford wrote:
> >
> > With a few exceptions, it should work.  The problematic systems are few.
> >
> > -d
> >
> > David Feuer wrote:
> >
> > > What is the current status of PC-card support?  I've seen ominous signs on
> > > this list about the state of support....  I have a laptop with a PCMCIA
> > > network card (a 3com thing). Will it work?
> >
> > --
> > "The difference between 'involvement' and 'commitment' is like an
> > eggs-and-ham breakfast: the chicken was 'involved' - the pig was
> > 'committed'."
> >
> >
> >
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/

--
"The difference between 'involvement' and 'commitment' is like an
eggs-and-ham breakfast: the chicken was 'involved' - the pig was
'committed'."



--------------912B6B0C5FC30388558993BB
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

--------------912B6B0C5FC30388558993BB--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

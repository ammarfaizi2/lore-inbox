Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S132180AbQK0Ano>; Sun, 26 Nov 2000 19:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S132202AbQK0And>; Sun, 26 Nov 2000 19:43:33 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:54128 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S132180AbQK0AnY>; Sun, 26 Nov 2000 19:43:24 -0500
Message-ID: <3A21A720.75A4EEB1@linux.com>
Date: Sun, 26 Nov 2000 16:13:20 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Subject: Re: [PATCH] modutils 2.3.20 and beyond
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu> <20001126164556.B1665@vger.timpanogas.org>
Content-Type: multipart/mixed;
 boundary="------------DABFB68F73B42FB6EE79B0CA"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------DABFB68F73B42FB6EE79B0CA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Jeff V. Merkey" wrote:

> On Sun, Nov 26, 2000 at 10:46:35PM +0000, Alan Cox wrote:
> > > +           {"ignore-versions", 0, 0, 'i'},
> >
> > I dont think we should encourage anyone to ignore symbol versions
>
> Anaconda will barf and require over 850+ changes to the scripts without
> it.  If you look at the patch, you will note that it's a silent switch
> that's only there to avoid a noisy error message from depmod.  It
> actually does nothing other than set a flag that also does nothing.
> -m simply maps to -F.

It's still a bad precedent.  Anaconda should have been written correctly in
the first place.

-d


--------------DABFB68F73B42FB6EE79B0CA
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

--------------DABFB68F73B42FB6EE79B0CA--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

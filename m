Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135214AbQK0Aqx>; Sun, 26 Nov 2000 19:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135215AbQK0Aqn>; Sun, 26 Nov 2000 19:46:43 -0500
Received: from nifty.blue-labs.org ([208.179.0.193]:55408 "EHLO
        nifty.Blue-Labs.org") by vger.kernel.org with ESMTP
        id <S135214AbQK0Aqb>; Sun, 26 Nov 2000 19:46:31 -0500
Message-ID: <3A21A7D9.9CE7077B@linux.com>
Date: Sun, 26 Nov 2000 16:16:26 -0800
From: David Ford <david@linux.com>
Organization: Blue Labs
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] modutils 2.3.20 and beyond
In-Reply-To: <20001126163655.A1637@vger.timpanogas.org> <E140AZB-0002Qh-00@the-village.bc.nu> <20001126164556.B1665@vger.timpanogas.org> <3A21968B.5CDB12BF@haque.net> <20001126170334.B1787@vger.timpanogas.org>
Content-Type: multipart/mixed;
 boundary="------------2E94DA9F219E10186317B6B1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------2E94DA9F219E10186317B6B1
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Jeff V. Merkey" wrote:

> On Sun, Nov 26, 2000 at 06:02:35PM -0500, Mohammad A. Haque wrote:
> > I'd rather have Anaconda changed rather than special casing standard
> > utils to account for distro handling.
>
> Great.  Then tell RedHat to rewrite it without the need for these switches.
> They will say NO.  It's a trivial change, and would save me a lot of hours
> rewriting scripts.  I did it once, but if RedHat has standardized on this
> set of switches, why not add them as alias commands?  It's a trivial
> patch.

Then let RedHat maintain their version of modutils.  RedHat isn't the
standard, nor should RedHat dictate to authors, nor should other distributions
and persons be affected by RedHat's methods.

If you don't like it, replace your depmod with a script that strips that flag
before calling the original depmod.

-d


--------------2E94DA9F219E10186317B6B1
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

--------------2E94DA9F219E10186317B6B1--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

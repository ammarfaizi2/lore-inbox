Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932364AbWEHPvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932364AbWEHPvj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 11:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932365AbWEHPvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 11:51:39 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:13362 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932364AbWEHPvj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 11:51:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Mh+a0onjTAS+SIlfoJC35+PTCOj4S/n3ox/sXFtfyz7MBHt4ZEFrSHWO34egZ7dp8IMgE1ZTOFiSMX5TU9h3+Uy7ogJIewBnFaeypwXcKbcgbxBQXWn3R6ZitXeISzRAt9ir9Mvix/3v5Ov0I+Cyv06KYu0QK9+6JkFI1wpM4OU=
Message-ID: <d9def9db0605080851k318a6b7x9f3f5103cabe7cc8@mail.gmail.com>
Date: Mon, 8 May 2006 17:51:38 +0200
From: "Markus Rechberger" <mrechberger@gmail.com>
To: "linux@horizon.com" <linux@horizon.com>
Subject: Re: [linux-usb-devel] New, yet unsupported USB-Ethernet adaptor
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20060506232311.7353.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060506232311.7353.qmail@science.horizon.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is anyone already on that issue?
Delock will send me a testdevice, I'll migrate the code to the new
usbnet framework then. Fixing the copyrights shouldn't be such a
problem there :)

Markus

On 6 May 2006 19:23:11 -0400, linux@horizon.com <linux@horizon.com> wrote:
> >>> Correct.  He is violating the license in a number of ways, though it
> >>> probably isn't totally intentional.
> >>
> >> Removing copyright and licence statements can't have been anything BUT
> >> intentional.
> >>
> >> That's really a basic rule, pretty much a "programming 101" thing.  You
> >> know, like "test your code", "don't remove other folks' copyrights",
> >> "don't try to change the licence on code copyrighted by someone else".
>
> That's programming 101 in a litigous country.  Some people are lucky
> enough to live in places where the law is treated with the respect
> it deserves.
>
> > Well, I suspect that poor soul did not know what (s)he was doing. They
> > are clearly trying to do the right thing... just paste back original
> > copyrights and be done with it.
>
> > No need to pull them into the loop, I'd say. What they done is wrong,
> > but we can correct it without their help.
>
> I'm with Pavel.  This was probably done by some underpaid junior coder
> in Bangalore who is utterly innocent of law, much less international law.
>
> The point is, they didn't try to claim it's proprietary and a trade secret.
> Misplacing the credit is very rude, but also easily fixable, especially
> once the duplicate code is properly factored out.
>
> A mention of "you shouldn't do that" is appropriate, but harassing a party
> who's basically being cooperative is unnecessary and counterproductive.
>
> A lot of expensive stonewalling in courts is caused by the fact that
> it's dangerous to admit that you did anything wrong; it has very little
> benefit, and lawyers proceed to just twist it into "and what else *aren't*
> they admitting to?"  Unless you want to encourage that behaviour,
> please don't make their lawyers regret that they let the source code
> out with the incriminating lack-of-comments.  Just fix it and move on.
>
> Save your righteous ire for the hard cases at gpl-violations.org.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


--
Markus Rechberger

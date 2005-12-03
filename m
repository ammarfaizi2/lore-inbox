Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbVLCVEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbVLCVEl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Dec 2005 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVLCVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Dec 2005 16:04:41 -0500
Received: from nproxy.gmail.com ([64.233.182.198]:25306 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750764AbVLCVEk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Dec 2005 16:04:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hxxds+aGl0KwcoD66F7PelUasUHfBJPSm5IEntXEEjI1tQReaGaAVEylatQO999v082y67UHdLttcnpwwCwVBu2CAEQkZMo/JUANvccSw0U6cdjxPsAYKynsD+0s9qXIKm8+S4jR66fOKeM56g1JZM+y1hbBlSa8AuBRbWBuFNI=
Message-ID: <f0cc38560512031304n4fcb1c3dn717e4a8e80fcbacd@mail.gmail.com>
Date: Sat, 3 Dec 2005 22:04:39 +0100
From: "M." <vo.sinh@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20051203201945.GA4182@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051203135608.GJ31395@stusta.de>
	 <9a8748490512030629t16d0b9ebv279064245743e001@mail.gmail.com>
	 <20051203201945.GA4182@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/3/05, Greg KH <greg@kroah.com> wrote:
> On Sat, Dec 03, 2005 at 03:29:54PM +0100, Jesper Juhl wrote:
> >
> > Why can't this be done by distributors/vendors?
>
> It already is done by these people, look at the "enterprise" Linux
> distributions and their 5 years of maintance (or whatever the number
> is.)
>
> If people/customers want stability, they already have this option.
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Yes but not home users with relatively new/bleeding edge hardware or
small projects writing for example a wifi driver or a security patch
or whatever without full time commitment to tracking kernel changes.

Enterprise products are suited for production servers,
school/government/companies desktops and not for "enthusiasts" or for
small kernel projects (they obviously cant write drivers or patches
for custom distro kernels). Those enthusiasts have to get mad with
performance regressions, new incompatibilities, new crashes etc.

My suggestion was to release a 2.6.X kernel every 6months reducing
kernel development fragmentation between different distros and giving
away stabler stuff.

Michele

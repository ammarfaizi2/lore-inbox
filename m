Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263056AbTCTXzw>; Thu, 20 Mar 2003 18:55:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263025AbTCTXzv>; Thu, 20 Mar 2003 18:55:51 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:17325 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S263012AbTCTXzt>; Thu, 20 Mar 2003 18:55:49 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Thu, 20 Mar 2003 16:04:37 -0800 (PST)
Subject: Re: Release of 2.4.21
In-Reply-To: <1048208493.4031.3.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0303201600370.18719-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

if official kernels were being released more rapidly then they are it
wouldn't be much of a problem (I can wait a week or two for this with no
problem) but it's currently several months between releases, and since
there are so many changes there is the potential that a new kernel could
be worse then what you are running.

yes I could download a patch and fix the kernel that way, but while I
understand how simple that is I can already hear the crys from management
about haphazardly patching things that then get put into production.

and as for the vendor kernels, I don't use them becouse they all make a
ton of changes that I don't want to deal with.

the stable kernel releases are a vendor for this situation and this
'vendor' has chosen to consider this bug not critical (along with a couple
others) which is a decision being questioned by folks.

David Lang


 On 21 Mar 2003, Alan Cox wrote:

> Date: 21 Mar 2003 01:01:34 +0000
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> To: Adrian Knoth <adi@drcomp.erfurt.thur.de>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: Release of 2.4.21
>
> On Thu, 2003-03-20 at 19:56, Adrian Knoth wrote:
> > (and glibc as well) to do the same. You cannot call 2.4.20 a stable kernel
> > with such a bug, so as a leader of the 2.4.x-series you cannot call the
> > whole branch "stable".
> >
> > World needs to update, best way to enforce is by a new release.
>
> The vendors have released updated kernels. Whats the problem ?
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

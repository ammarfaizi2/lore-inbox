Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTAGS1x>; Tue, 7 Jan 2003 13:27:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267458AbTAGS1x>; Tue, 7 Jan 2003 13:27:53 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:31427 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267455AbTAGS1w> convert rfc822-to-8bit; Tue, 7 Jan 2003 13:27:52 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Bill Davidsen <davidsen@tmr.com>, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: Honest does not pay here ...
Date: Tue, 7 Jan 2003 12:33:49 -0600
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.3.96.1030107112114.15952B-100000@gatekeeper.tmr.com>
In-Reply-To: <Pine.LNX.3.96.1030107112114.15952B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301071233.49252.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 07 January 2003 10:32 am, Bill Davidsen wrote:
> On Tue, 7 Jan 2003, Matthias Andree wrote:
> > Only that you can't trust in the el-cheapo vendors claiming Linux
> > support, and an independent certification is needed (not only for Linux,
> > for the *BSDs as well). Without a trusted certification, some crooks may
> > try to claim Linux support and it won't quite work out.
>
> To be honest, support for Windows is much easier than Linux. There are
> only a few versions of Windows out, in terms of how many versions are
> needed, and in many cases the same driver will work for several versions.
>
> For Linux, there are not only dozens of kernel versions around, but the
> uni and smp versions are not the same. Vendors who want to provide drivers
> really want to provide the binary even if the module is open source, just
> because the average person has no desire to build any part of a kernel.
>
> So it is possible to release a driver and claim in good faith that it
> works, and still not have it work with *your* system. Not because the
> vendor is evil, incompetent, a "crook" (your term), dishonest, or even
> that testing was poor, but because all kernels are very much not created
> equal.

I would still incline toward the "testing was poor". If the vendor just says 
"works with Linux", and not "works with Linux 2.4.18", then it is deceptive, 
and worst case it becomes dishonest.

> Try to understand why vendors want to ship binary modules and why they
> don't always work before making accusations.

Been there (though it wasn't within the last 20 years). The only justification
for not releasing the specifications is incompetent hardware design worked
around by software. Releasing the software would reveal how incompetent
some designers are.

> All that said, an independent testing service would be of use to the
> vendors, because they could find things before shipping and have someone
> to share the blame if the module didn't work with another kernel.

Releasing the source would save more money than the testing service costs.
Besides, I'm not buying a driver - I only want the device, and the specs on 
the device that may allow me or someone else to create a driver for Linux
or some other purpose (ie - a dedicated, embeded system not necessarily based
on Linux)...

Personally, I view binary only drivers as evidence of incompetence, or
embarassement over how poor a design is in the first place...
-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.

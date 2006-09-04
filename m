Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932279AbWIDFHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932279AbWIDFHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbWIDFHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:07:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.225]:4454 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932279AbWIDFHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:07:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jYaGJ50bg3RpJqSM4WKIARuSr5uY6O675Ga9OgvAK6xw/HPuJ54pTTQBa8BYgIXLd572h1cdjY4OW2dZDFbviWVoApnuzepCmifWTL/YPf6EA0qbr5JH64VvBOjy8gR05cSYR2LcWi5AGHBF48RsEp5TguJQujJs0XrmYJwaPFU=
Message-ID: <9e0cf0bf0609032207j6471357do5b990bc4e90ea74d@mail.gmail.com>
Date: Mon, 4 Sep 2006 08:07:02 +0300
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Josh Boyer" <jwboyer@gmail.com>
Subject: Re: [PATCH 00/26] Dynamic kernel command-line
Cc: "Andi Kleen" <ak@suse.de>, "Matt Domsch" <Matt_Domsch@dell.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, davej@codemonkey.org.uk, Riley@williams.name,
       trini@kernel.crashing.org, davem@davemloft.net, ecd@brainaid.de,
       jj@sunsite.ms.mff.cuni.cz, anton@samba.org, wli@holomorphy.com,
       lethal@linux-sh.org, rc@rc0.org.uk, spyro@f2s.com, rth@twiddle.net,
       avr32@atmel.com, hskinnemoen@atmel.com, starvik@axis.com,
       ralf@linux-mips.org, matthew@wil.cx, grundler@parisc-linux.org,
       geert@linux-m68k.org, zippel@linux-m68k.org, paulus@samba.org,
       schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com,
       uclinux-v850@lsi.nec.co.jp, chris@zankel.net
In-Reply-To: <625fc13d0609031801o2ecfc5eawaf5c36ae406236b8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200609040050.13410.alon.barlev@gmail.com>
	 <625fc13d0609031801o2ecfc5eawaf5c36ae406236b8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/06, Josh Boyer <jwboyer@gmail.com> wrote:
> On 9/3/06, Alon Bar-Lev <alon.barlev@gmail.com> wrote:
> >
> > This patch is for linux-2.6.18-rc5-mm1 and is divided to
> > target each architecture. I could not check this in any
> > architecture so please forgive me if I got it wrong.
>
> You didn't test this on _any_ architecture?  It's a bit bold to send
> out a patch like this without at least testing it on one architecture.

I tested it on i386.
I am truly sorry... But I don't have access to other architectures.

Best Regards,
Alon Bar-Lev.

-- 
VGER BF report: H 0

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280769AbRKBSc1>; Fri, 2 Nov 2001 13:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280770AbRKBScR>; Fri, 2 Nov 2001 13:32:17 -0500
Received: from [208.232.58.25] ([208.232.58.25]:46542 "EHLO kronos.usol.com")
	by vger.kernel.org with ESMTP id <S280769AbRKBSb4>;
	Fri, 2 Nov 2001 13:31:56 -0500
Subject: Re: APM/ACPI
From: Sean Middleditch <smiddle@twp.ypsilanti.mi.us>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15zj8q-0003CI-00@the-village.bc.nu>
In-Reply-To: <E15zj8q-0003CI-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.30.16.08 (Preview Release)
Date: 02 Nov 2001 13:31:19 -0500
Message-Id: <1004725879.4921.36.camel@smiddle>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, not to point fingers or anything, but...

"The WindowsXP that came preinstalled supported it!"

I dunno, perhaps there is some proprietary protocol?  Is ACPI backwards
compat with APM?  I mean, if the laptop doesn't support APM, would that
mean it can't support ACPI?

Thanks again,
Sean Etc.

On Fri, 2001-11-02 at 13:34, Alan Cox wrote:
> > I don't see anything regarding ACPI.  I also read that ACPI should
> > automatically take over APM if support is available.  How can I tell if
> > I'm not using ACPI because it's not supported, or because it's not
> > compiled in?
> 
> Red Hat shipped kernels dont include acpi. The -1% for the battery
> percentage does look like the laptop may not support much APM if any
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



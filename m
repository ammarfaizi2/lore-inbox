Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274875AbRLLLBj>; Wed, 12 Dec 2001 06:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277653AbRLLLBU>; Wed, 12 Dec 2001 06:01:20 -0500
Received: from ns.suse.de ([213.95.15.193]:16646 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S274875AbRLLLBS>;
	Wed, 12 Dec 2001 06:01:18 -0500
Date: Wed, 12 Dec 2001 12:01:17 +0100
From: Stefan Reinauer <stepan@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [OT?] SuSe kernel
Message-ID: <20011212120117.A29895@suse.de>
In-Reply-To: <20011211193048.A22075@pcmaftoul.esrf.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011211193048.A22075@pcmaftoul.esrf.fr>
User-Agent: Mutt/1.3.22.1i
X-OS: Linux 2.4.13 ia64
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Samuel Maftoul <maftoul@esrf.fr> [011211 19:30]:
> In SuSe's kernel there is a nice feature but I cannot  found where is
> the code that does it and so I cannot play with it 8-).
> The thing I'm talking about is grpahical boot + graphical first console.
> I glanced at include/asm-i386/linux_logo.h but it doesn't differ.
> Can someone help me ?
>         Sam

The boot splash patch I made for SuSE allows you to use any jpg picture
as a background console. You can define the text area freely on this
picture.

Have a look at http://www.suse.de/~stepan/bootsplash/ to find the latest
patches. Currently they only apply against a kernel already patched with
bootlogo version patch by Gerard Sharp <gsharp@ihug.co.nz> (this patch can
be downloaded from above location, too)

Any ideas/bug reports are welcome!

Best regards,
  Stefan Reinauer

-- 
Ok 

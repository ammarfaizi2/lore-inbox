Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271948AbRIIM2P>; Sun, 9 Sep 2001 08:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271950AbRIIM2G>; Sun, 9 Sep 2001 08:28:06 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:47373 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S271948AbRIIM14>; Sun, 9 Sep 2001 08:27:56 -0400
Message-ID: <3B99DCFC.22918D3E@eisenstein.dk>
Date: Sat, 08 Sep 2001 10:55:24 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guus Sliepen <guus@warande3094.warande.uu.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: AMD 760 (761?) AGP
In-Reply-To: <3B97D334.E27BDA25@pp.htv.fi> <3B998088.6070206@zianet.com> <20010909130523.B7635@sliepen.warande.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guus Sliepen wrote:

> On Fri, Sep 07, 2001 at 08:20:56PM -0600, Steven Spence wrote:
>
> > If you have it as a module try loading it with  agp_try_unsupported=1.
> > If its not a module try appending it to lilo.  I have that chipset and
> > everything
> > works fine with those options.  I have a GF2U however not a Radeon.  I can
> > get 4x working with side band addressing and fast write.
>
> I have an Asus A7M266 with a AMD 761 chipset. I can get agpgart to work with
> agp_try_unsupported=1, and it works fine, but I only get AGP 1x support.
>

I also have an Asus A7M266, and my GF3 (Asus V8200 Deluxe) works just fine even
without the agp_try_unsupported=1 option (both with the nv driver and the
binary only NVidia driver)..


Best regards,
Jesper Juhl



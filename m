Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316856AbSH0T0C>; Tue, 27 Aug 2002 15:26:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSH0T0C>; Tue, 27 Aug 2002 15:26:02 -0400
Received: from mail.gmx.de ([213.165.64.20]:25278 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316856AbSH0T0B>;
	Tue, 27 Aug 2002 15:26:01 -0400
From: Felix Seeger <felix.seeger@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: USB mouse problem, kernel panic on startup in 2.4.19
Date: Tue, 27 Aug 2002 21:30:11 +0200
User-Agent: KMail/1.4.6
References: <200208272011.51691.felix.seeger@gmx.de> <200208272023.52351.felix.seeger@gmx.de> <20020827183119.GB23700@kroah.com>
In-Reply-To: <20020827183119.GB23700@kroah.com>
Cc: Greg KH <greg@kroah.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200208272130.14728.felix.seeger@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

No, sorry. Doesn't help.
Is that a patch for 2.4.20-pre4 ? I am using 2.4.19.

Oh, the shift and the numlock leds are blinking.

thanks
have fun
Felix

Am Dienstag, 27. August 2002 20:31 schrieb Greg KH:
> On Tue, Aug 27, 2002 at 08:23:47PM +0200, Felix Seeger wrote:
> > Kernel BUG at usb-ohci.h:464!
>
> Can you try the patch at:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-usb-ohci-
>2.4.20-pre4.patch and let us know if it fixes this problem or not?
>
> thanks,
>
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9a9NGS0DOrvdnsewRAkIQAJ4zXvVDstvM6UHcYktCP+dSfISNTgCffJ+q
fyBgD16M6Dkdpmfazv7PTis=
=e+kq
-----END PGP SIGNATURE-----


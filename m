Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264961AbTFCO7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265038AbTFCO7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:59:54 -0400
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:38806 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264961AbTFCO7x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:59:53 -0400
From: Bob Johnson <livewire@gentoo.org>
Reply-To: livewire@gentoo.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: siimage driver status
Date: Tue, 3 Jun 2003 10:13:14 -0500
User-Agent: KMail/1.5.2
References: <Pine.LNX.4.44.0306031009390.20263-100000@bork.hampshire.edu> <1054648192.9234.24.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1054648192.9234.24.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306031013.17835.livewire@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Has anything been addressed to help the instant lock up when enabling dma 
that alot of users are reporting?


On Tuesday 03 June 2003 08:49 am, Alan Cox wrote:
> On Maw, 2003-06-03 at 15:11, Wm. Josiah Erikson wrote:
> > Is there some silly hack I can do to the driver code to force all devices
> > to DMA on bootup? Everything works fine except for that. I'm using
> > 2.4.21-rc6-ac1
>
> -ac2 knows the firmware doesn't intialise DMA mode and shouldn't be used
> as a safety guide.
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3LsNxJgsCy9JAX0RAu1nAKCoenOMiRTv2ePaViUpFir6haKa/QCfXes7
wXfUqridTKwYel5uvId1QPI=
=AyVa
-----END PGP SIGNATURE-----


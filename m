Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287972AbSAHI36>; Tue, 8 Jan 2002 03:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287971AbSAHI3i>; Tue, 8 Jan 2002 03:29:38 -0500
Received: from mailer.zib.de ([130.73.108.11]:1763 "EHLO mailer.zib.de")
	by vger.kernel.org with ESMTP id <S287968AbSAHI31>;
	Tue, 8 Jan 2002 03:29:27 -0500
Date: Tue, 8 Jan 2002 09:29:21 +0100
From: Sebastian Heidl <heidl@zib.de>
To: =?iso-8859-1?Q?J=F6rn_Nettingsmeier?= 
	<nettings@folkwang-hochschule.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.17 usbnet usb.c: USB device not accepting new address
Message-ID: <20020108092921.D7261@csr-pc1.zib.de>
In-Reply-To: <3C3A0B1A.6441FC74@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C3A0B1A.6441FC74@folkwang-hochschule.de>; from nettings@folkwang-hochschule.de on Mon, Jan 07, 2002 at 09:54:50PM +0100
X-www.distributed.net: 4 packets (26.00 stats units) [1,909,563 keys/s]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2002 at 09:54:50PM +0100, Jörn Nettingsmeier wrote:
> when i try to connect my ipaq to the desktop via usbnet, i see the
> following:
> 
>  kernel: hub.c: port 2, portstatus 103, change 0, 12 Mb/s
>  kernel: hub.c: USB new device connect on bus1/2, assigned device
> number 6
>  kernel: usb.c: USB device not accepting new address=6 (error=-110)
a guy over here had the same problem when using a quite long USB extension
cable for a USB-camera. whithout the extension it worked fine.

try another cable if you can.

regards,
_sh_


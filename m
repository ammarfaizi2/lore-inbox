Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316790AbSFAQ4k>; Sat, 1 Jun 2002 12:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316830AbSFAQ4j>; Sat, 1 Jun 2002 12:56:39 -0400
Received: from pop.gmx.net ([213.165.64.20]:47629 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S316790AbSFAQ4i>;
	Sat, 1 Jun 2002 12:56:38 -0400
Date: Sat, 1 Jun 2002 10:34:03 +0200
From: Nikolaus Filus <NFilus@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: Re: de4x5 driver: driver freezes system
Message-ID: <20020601103403.A750@nfilus.dyndns.org>
In-Reply-To: <20020531233651.B595@nfilus.dyndns.org> <3CF7F60F.40802@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31, 2002 at 06:15:43PM -0400, Jeff Garzik wrote:
>Nikolaus Filus wrote:
>
>>Hi,
>>
>>I'm a maintainer (one of several :) of a little linux distribution called
>>rocklinux (www.rocklinux.org) and tried to make a fits-for-everyone kernel,
>>but got some booting problems with the de4x5 driver.
>>When compiling the driver into the kernel and no appropriate card is
>>installed in the system the booting stops and the computer freezes. I tested
>>this with kernel 2.4.16 and .18 on my Toshiba laptop and reported by other
>>users. I would like to provide more information, when needed - just say what
>
>Does the tulip driver not work for you?

It's not a problem of working or not working, but this driver freezes a
system when compiled into the kernel and no such card is present. That
shouldn't happen. There isn't even any hint during booting, that would point
to the driver, when something goes wrong.

Nikolaus

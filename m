Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290070AbSAWUuS>; Wed, 23 Jan 2002 15:50:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290072AbSAWUuI>; Wed, 23 Jan 2002 15:50:08 -0500
Received: from dns.uni-trier.de ([136.199.8.101]:3807 "EHLO
	rzmail.uni-trier.de") by vger.kernel.org with ESMTP
	id <S290070AbSAWUtv> convert rfc822-to-8bit; Wed, 23 Jan 2002 15:49:51 -0500
Date: Wed, 23 Jan 2002 21:49:49 +0100 (CET)
From: Daniel Nofftz <nofftz@castor.uni-trier.de>
X-X-Sender: nofftz@infcip10.uni-trier.de
To: Hans-Peter Jansen <hpj@urpla.net>
cc: Daniel Nofftz <nofftz@castor.uni-trier.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <20020123201626.2EDEF1458@shrek.lisa.de>
Message-ID: <Pine.LNX.4.40.0201232148210.2478-100000@infcip10.uni-trier.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, Hans-Peter Jansen wrote:

> Hi Daniel & folks,
>
> just tried your patch on my (diskless) asus a7v133 (kt133) with 1.2 GHz
> Athlon. I normally had 14% base load spend in apmd-idled and a CPU temp.
> of 45°C. After getting it to work, I see a base load of around 1% (mostly
> spend in artsd), but CPU is only 1°-2° less now :-( I hoped, it it
> would be more). Nevertheless, it is a very important patch nowadays where
> temperature is the last technical barrier, and energy saving an economic
> necessity.

hmmm ... 1°-2° lesser than apm or lesser than "without any powersafing
function" ?
do you have entered the amd_disconnect=yes flag at boot-time (LILO ?)


>
> Many thanks and greetings from Berlin to Trier ;)
>   Hans-Peter

thanks ... greetings back to you ... :)

daniel


# Daniel Nofftz
# Sysadmin CIP-Pool Informatik
# University of Trier(Germany), Room V 103
# Mail: daniel@nofftz.de


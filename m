Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293722AbSB1XGg>; Thu, 28 Feb 2002 18:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310194AbSB1XEb>; Thu, 28 Feb 2002 18:04:31 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:8204 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S310193AbSB1XBP>; Thu, 28 Feb 2002 18:01:15 -0500
Date: Thu, 28 Feb 2002 18:52:25 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Dennis, Jim" <jdennis@snapserver.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: Congrats Marcelo,
In-Reply-To: <2D0AFEFEE711D611923E009027D39F2B153AD4@cdserv.meridian-data.com>
Message-ID: <Pine.LNX.4.21.0202281849450.2391-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Feb 2002, Dennis, Jim wrote:

> Marcelo,
> 
>  Contratulations on your first "official" kernel release.  It seems to
> have gone
>  well (except for some complaints on slashdot about -rc4 SPARC patches
> missing from
>  the patch, but apparently in the full tarball).
> 
>  Now I need to know about the status of several unofficial patches:
> 
> 	XFS

Want to see stable in -ac first.

> 	LVM

Its on 2.4 already.

> 	i2c
> 	Crypto
> 	FreeS/WAN KLIPS
> 	LIDS

I think its not possible to distribute crypto stuff in the stock kernel.

Am I wrong? 

> 	rmap

I need to see it running in production for more time.

>  Marcelo, there were some i2c updates included in the lmsensors package,
> have they
>  submitted those to you for integration into 2.4.19?

Nope. I could well integrate lm_sensors in the future.



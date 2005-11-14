Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVKNM3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVKNM3m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbVKNM3m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:29:42 -0500
Received: from mxfep02.bredband.com ([195.54.107.73]:34987 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S1751105AbVKNM3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:29:42 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="3.97,326,1125871200"; 
   d="scan'208"; a="9946590:sNHT29758239"
Message-ID: <4378832E.6050105@stesmi.com>
Date: Mon, 14 Nov 2005 13:29:34 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 939 pin Opteron vs. Athlon 64? What's the difference?
References: <43753726.8060205@perkel.com>
In-Reply-To: <43753726.8060205@perkel.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.7; VAE 6.29.0.5; VDF 6.29.0.100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marc Perkel wrote:
> OK - I'm confused. What is the difference between an Athlon 64 and a 939
> pin Opteron? Or the difference between a 939 pin dual core Athlon and a
> 939 pin dual core opteron?
> 
> I understand that the 940 pin Opterons can be used on multiple processor
> boards. But I just don't get it about using a single opteron.
> 
> Also - while I'm asking - AMD Semprtons now are 64 bit - so what's the
> difference between a 64 bit Sempton and a 64 Bit athlon?
> 

While this is an interesting subject, I ponder what it has to do on the
Linux Kernel development list.

939 pin opterons use unregistered memory and 940 uses registered memory.

Opterons in 939 pin packaging are the same as the FX- chips basically.

64bit Sempron has less cache than 64bit Athlon.

// Stefan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFDeIMuBrn2kJu9P78RAvizAKCjqsLK09DzFY5G1DGPXTg8AaLdlwCgsFyz
FtxDVZ7fCANI/gGK+hFVtmA=
=wHHj
-----END PGP SIGNATURE-----

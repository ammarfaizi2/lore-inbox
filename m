Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291805AbSBNRkb>; Thu, 14 Feb 2002 12:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291802AbSBNRkQ>; Thu, 14 Feb 2002 12:40:16 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:61357 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S291805AbSBNRjv>; Thu, 14 Feb 2002 12:39:51 -0500
Date: Thu, 14 Feb 2002 12:35:33 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: Mark Staudinger <mark@staudinger.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.12 on Pentium?
In-Reply-To: <200202141526.g1EFQfjC035904@mark.staudinger.net>
Message-ID: <Pine.LNX.4.33.0202141233100.22263-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Feb 2002, Mark Staudinger wrote:

>
>Is there any known problem with running kernel 2.4.12 on a P54/P55 CPU?  I'm
>unable to get a 2.4.12 kernel to boot on a pentium class machine, regardless
>of what I choose for the "Processor Family" support in the config.
>
>A similar (if not identical) config of kernel 2.4.5 works just fine, even if
>compiled for 686/Celeron processor family.

copy the .config from the 2.4.5 directory and do a 'make oldconfig' just
to be sure.

--Drew Vogel


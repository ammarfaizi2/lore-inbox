Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281817AbRLDFLI>; Tue, 4 Dec 2001 00:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281248AbRLDFK6>; Tue, 4 Dec 2001 00:10:58 -0500
Received: from mail12.speakeasy.net ([216.254.0.212]:12421 "EHLO
	mail12.speakeasy.net") by vger.kernel.org with ESMTP
	id <S281161AbRLDFKo>; Tue, 4 Dec 2001 00:10:44 -0500
Subject: Re: Compilation error with Kernels 2.4.16 && 2.5.X
From: safemode <safemode@speakeasy.net>
To: real <haxmail@subdimension.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C0B921F.80206@subdimension.com>
In-Reply-To: <3C0B921F.80206@subdimension.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 04 Dec 2001 00:10:42 -0500
Message-Id: <1007442642.5959.1.camel@psuedomode>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-12-03 at 09:54, real wrote:
> drivers/char/char.o(.data+0x46b4): undefined reference to `local symbols 
> in discarded section .text.exit'
> drivers/net/net.o(.data+0xbb4): undefined reference to `local symbols in 
> discarded section .text.exit'
> drivers/sound/sounddrivers.o(.data+0xb4): undefined reference to `local 
> symbols in discarded section .text.exit'
> drivers/usb/usbdrv.o(.data+0x234): undefined reference to `local symbols 
> in discarded section .text.exit'
> make: *** [vmlinux] Error 1

Same here.  How many other people are finding this to be a problem?   
same problem with 2.4.17-pre2  


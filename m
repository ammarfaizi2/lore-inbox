Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310199AbSB1Xa4>; Thu, 28 Feb 2002 18:30:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293698AbSB1X2q>; Thu, 28 Feb 2002 18:28:46 -0500
Received: from mailout08.sul.t-online.com ([194.25.134.20]:6833 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S310203AbSB1XXC>; Thu, 28 Feb 2002 18:23:02 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.org>
To: "Hua Zhong" <hzhong@cisco.com>, <root@chaos.analogic.com>
Subject: Re: question about running program from a RAM disk
Date: Thu, 28 Feb 2002 23:55:30 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.95.1020228170705.2670A-100000@chaos.analogic.com> <01bc01c1c0a6$a3c315e0$bb3147ab@amer.cisco.com>
In-Reply-To: <01bc01c1c0a6$a3c315e0$bb3147ab@amer.cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16gZsW-0lGD9kC@fmrl01.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 February 2002 23:24, Hua Zhong wrote:
> In the final system we are going to turn off swap. I had dreamed that Linux
> could directly use the page frame on the RAM disk instead of doing another
> copy :-)
>
> Thanks for the reply

You could use ramfs, which does so for sure.
I am actually not sure about the ramdisk code.

	Regards
		Oliver

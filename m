Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSBYPi7>; Mon, 25 Feb 2002 10:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291121AbSBYPit>; Mon, 25 Feb 2002 10:38:49 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:51661 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S290818AbSBYPik>; Mon, 25 Feb 2002 10:38:40 -0500
Date: Mon, 25 Feb 2002 17:26:35 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: David Stroupe <dstroupe@keyed-upsoftware.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        KernelNewbies <kernelnewbies@nl.linux.org>
Subject: Re: Q: Interfacing to driver
In-Reply-To: <3C797770.3000206@keyed-upsoftware.com>
Message-ID: <Pine.LNX.4.44.0202251724420.20027-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Feb 2002, David Stroupe wrote:

> I have created a driver for a custom board.  This driver exports the 
> functions that I need to access from my user programs to control the 
> card.  How do I declare and call this driver function within my user 
> code so that it will call the device driver function?

Usually done with an ioctl (Check out many of the character drivers for 
example), you oughta send these kinda questions to the kernelnewbies list 
though (CCd)

	Zwane



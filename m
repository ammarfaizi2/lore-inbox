Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288971AbSA3IP0>; Wed, 30 Jan 2002 03:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288956AbSA3IN5>; Wed, 30 Jan 2002 03:13:57 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:23557 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288971AbSA3ING>;
	Wed, 30 Jan 2002 03:13:06 -0500
Date: Wed, 30 Jan 2002 00:11:53 -0800
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130081153.GB23812@kroah.com>
In-Reply-To: <E16Vp2w-0000CA-00@starship.berlin> <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201292326110.1428-100000@penguin.transmeta.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 02 Jan 2002 05:00:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 11:48:05PM -0800, Linus Torvalds wrote:
> 
> How many other people are actually using bitkeeper already for the kernel?

I am, for the USB and PCI hotplug stuff:
	http://linuxusb.bkbits.net/

It makes tracking what patches got applied, and which didn't, and
forward porting those that didn't to the next release, a breeze.

My trees are world readable, and people are welcome to send me patches
against it, or even bitkeeper changesets, but I have yet to receive one
of those yet :)

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbRA3QYs>; Tue, 30 Jan 2001 11:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130526AbRA3QYi>; Tue, 30 Jan 2001 11:24:38 -0500
Received: from pD902B913.dip.t-dialin.net ([217.2.185.19]:55680 "EHLO
	defiant.crash") by vger.kernel.org with ESMTP id <S130352AbRA3QYZ>;
	Tue, 30 Jan 2001 11:24:25 -0500
From: Ronald Lembcke <es186@fen-net.de>
Date: Tue, 30 Jan 2001 17:24:28 +0100
Cc: linux-kernel@vger.kernel.org
Subject: Re: no boot with 2.4.x
Message-ID: <20010130172428.A4899@defiant.crash>
In-Reply-To: <98087051420864-30100120864rhairyes@lee.k12.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <98087051420864-30100120864rhairyes@lee.k12.nc.us>; from rhairyes@lee.k12.nc.us on Tue, Jan 30, 2001 at 04:01:54PM +0000
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!


On Tue, Jan 30, 2001 at 04:01:54PM +0000, Ryan Hairyes wrote:
> I compiled the 2.4 kernel on my laptop last night.
> After editing lilo, I rebooted the machine. I selected
> this new kernel and when it began to boot, it told me
> that it was uncompressing the kernel and that the 
> kernel uncompression was ok.  Then it just froze.  Any
> ideas?

The same happened to me (not on a laptop) when I forgot to select
the right CPU-Type (AMD K6-2) and Pentium 3 was still selected.

Und weg... 
           Roni
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

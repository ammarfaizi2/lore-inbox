Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281239AbRKERDW>; Mon, 5 Nov 2001 12:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281238AbRKERDM>; Mon, 5 Nov 2001 12:03:12 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:48132 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S281239AbRKERDG>; Mon, 5 Nov 2001 12:03:06 -0500
Message-Id: <200111051703.fA5H32Y92172@aslan.scsiguy.com>
To: tony@softins.clara.co.uk (Tony Mountifield)
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx problems with AHA2930CU 
In-Reply-To: Your message of "05 Nov 2001 16:39:46 GMT."
             <9s6fci$3f7$1@softins.clara.co.uk> 
Date: Mon, 05 Nov 2001 10:03:02 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have been running fine for over two months with 2.2.19 and the old 5.1.31
>SCSI driver. When Red Hat 7.2 came out recently I though I would try again,
>and created a boot floppy and a driver floppy.
>
>Booting with these still displayed the problems I described.
>Using aic7xxx_mod (6.1.13) instead of aic7xxx resulted in a kernel panic.

Can you provide any information about the kernel panic?  6.1.13 is still
quite old.  You may have better luck using version 6.2.4, but I can't
really say without knowing more about your system, the devices on the
bus, and the nature of the crash.  The 2930CU seems to work okay here.

Latest aic7xxx drivers can be found here:

http://people.FreeBSD.org/~gibbs/linux/

--
Justin

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279650AbRJXXyw>; Wed, 24 Oct 2001 19:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279651AbRJXXym>; Wed, 24 Oct 2001 19:54:42 -0400
Received: from mail1.amc.com.au ([203.15.175.2]:41988 "HELO mail1.amc.com.au")
	by vger.kernel.org with SMTP id <S279650AbRJXXyh>;
	Wed, 24 Oct 2001 19:54:37 -0400
Message-Id: <5.1.0.14.0.20011025095018.02485d50@mail.amc.localnet>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Thu, 25 Oct 2001 09:55:09 +1000
To: linux-kernel@vger.kernel.org
From: Stuart Young <sgy@amc.com.au>
Subject: Re: SiS/Trident 4DWave sound driver oops
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E15w4Ga-0006Q0-00@the-village.bc.nu>
In-Reply-To: <5.1.0.14.0.20011023154226.00a20ba0@mail.amc.localnet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:19 PM 23/10/01 +0100, Alan Cox wrote:
> > This kernel oops is totally reproducible (on every occasion) in 2.4.9,
> > 2.4.10, and 2.4.12. I have not tried earlier kernels in the 2.4 series,
> > but have tried 2.2.19pre17 (will explain other SiS Chipset funny business
> > in another message). All kernels were compiled while the machine was
> > running 2.2.19pre17.
>
>Does this problem go away if you build the driver modular.  Im wondering
>if it matches another mysterious and similar report

I've built the trident driver as a module, and tried the sound support as 
both a module and in-line, with the same results.

Haven't tried the trident driver and sound support in-line together. I'll 
give this a try and see if there is any difference, or wether my machine 
just oops's at boot.


Stuart Young - sgy@amc.com.au
(aka Cefiar) - cefiar1@optushome.com.au

[All opinions expressed in the above message are my]
[own and not necessarily the views of my employer..]


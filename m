Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132413AbRCaPBf>; Sat, 31 Mar 2001 10:01:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132414AbRCaPB1>; Sat, 31 Mar 2001 10:01:27 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:50189 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S132413AbRCaPBL>; Sat, 31 Mar 2001 10:01:11 -0500
Message-Id: <200103311500.f2VF0Qs50837@aslan.scsiguy.com>
To: Peter Enderborg <pme@ufh.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: Version 6.1.6 of the aic7xxx driver availalbe 
In-Reply-To: Your message of "Sat, 31 Mar 2001 11:58:14 +0200."
             <3AC5AA35.24A6320A@ufh.se> 
Date: Sat, 31 Mar 2001 08:00:26 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I upgraded to 2.4.3 from 2.4.1 today and I get a lot of recovery on the scsi
>bus.
>I also upgraded to the "latest" aic7xxx driver but still the sam problems.
>A typical revery in my logs.

Can you resend the recovery information after booting with "aic7xxx=verbose".
This will provide more information about the timeout which will hopefully
allow me to narrow down the problem.  A full dmesg of the system would
be useful too as that will include the device inquiry data.

--
Justin

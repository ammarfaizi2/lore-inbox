Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310197AbSCKQjn>; Mon, 11 Mar 2002 11:39:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310199AbSCKQjb>; Mon, 11 Mar 2002 11:39:31 -0500
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:48562 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S310197AbSCKQjR>; Mon, 11 Mar 2002 11:39:17 -0500
Date: Mon, 11 Mar 2002 09:37:58 -0700
Message-Id: <200203111637.g2BGbww03811@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] KERN_INFO 2.4.19-pre2 devfs 
In-Reply-To: <200203111343.g2BDhRq05326@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200203111343.g2BDhRq05326@Port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko writes:
> Primary purpose of this patch is to make KERN_WARNING and
> KERN_INFO log levels closer to their original meaning.
> Today they are quite far from what was intended.
> Just look what kernel writes at the WARNING level
> each time you boot your box!
> 
> Diff for devfs.

I've already posted a patch which adds KERN_* to all printk()'s in
devfs (devfs-patch-v199.9). I even submitted it to Marcelo, but we
were in 2.4.18-rc1 so he deferred it. It's queued for resubmission. Be
patient.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

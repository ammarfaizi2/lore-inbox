Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130117AbQLNPiL>; Thu, 14 Dec 2000 10:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130140AbQLNPiC>; Thu, 14 Dec 2000 10:38:02 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:9732 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S130117AbQLNPhz>; Thu, 14 Dec 2000 10:37:55 -0500
Message-Id: <200012141507.eBEF7Ls48966@aslan.scsiguy.com>
To: "Steven N. Hirsch" <shirsch@adelphia.net>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Adaptec AIC7XXX v 6.0.6 BETA Released 
In-Reply-To: Your message of "Thu, 14 Dec 2000 10:03:29 EST."
             <Pine.LNX.4.21.0012141001380.1522-100000@pii.fast.net> 
Date: Thu, 14 Dec 2000 08:07:21 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I figured as much.  I will test for the #define, stash it in a #define
>> unique within my namespace, and #define it back in hosts.c should my
>> local define exist.
>
>Justin,
>
>While you're at it, can you have the new driver provide status information
>under /proc/scsi/aic7xxx?  There is simply an empty pseudo-file called '0'
>instead of the display provided by the current driver.
>
>Steve

I don't know when the /proc stuff will return or what data will be
provided there.

--
Justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

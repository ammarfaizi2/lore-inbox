Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130325AbRAWKoR>; Tue, 23 Jan 2001 05:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129806AbRAWKoH>; Tue, 23 Jan 2001 05:44:07 -0500
Received: from 213-120-138-140.btconnect.com ([213.120.138.140]:9988 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130374AbRAWKoD>;
	Tue, 23 Jan 2001 05:44:03 -0500
Date: Tue, 23 Jan 2001 10:45:32 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Chmouel Boudjnah <chmouel@mandrakesoft.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.1-pre8/10 klogd taking 100% of CPU time -- bug?
In-Reply-To: <m3g0iaxzr6.fsf@giants.mandrakesoft.com>
Message-ID: <Pine.LNX.4.21.0101231044220.1386-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jan 2001, Chmouel Boudjnah wrote:

> Tigran Aivazian <tigran@veritas.com> writes:
> 
> > Btw, this only happens on my laptop and not on the desktop. It only
> > happens _after_ some activity but I have not yet managed to narrow down
> > exactly what activity.
> 
> i got the same problems on my desktop machine (Dell P4 which support
> (broken) APM) and not on my laptop :\

I forgot top say that my laptop is identified (by DMI) as:


BIOS Vendor: Dell Computer Corporation
BIOS Version: A03
BIOS Release: 01/29/2000
System Vendor: Dell Computer Corporation.
Product Name: Latitude CPx H450GT             .
Version .
Serial Number .
Board Vendor: Dell Computer Corporation.
Board Name: Latitude CPx H450GT      .
Board Version: .
Asset Tag: Ñ^L.
Asset Tag: Ò^L.


Btw, that Asset Tag printk's are surely buggy, aren't they? Aren't they
supposed to dump in hex instead of some unprintable stuff?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWJYOyZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWJYOyZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 10:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbWJYOyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 10:54:25 -0400
Received: from adsl-186-246.37-151.net24.it ([151.37.246.186]:50727 "EHLO
	zeus.abinetworks.biz") by vger.kernel.org with ESMTP
	id S932446AbWJYOyY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 10:54:24 -0400
Message-ID: <453F7A09.10702@abinetworks.biz>
Date: Wed, 25 Oct 2006 16:51:53 +0200
From: Gianluca Alberici <gianluca@abinetworks.biz>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041022)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
References: <453EEE46.9040600@perkel.com>
In-Reply-To: <453EEE46.9040600@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc,

2.6.16.11 works. I tell u because i got an M2E with 1GB ram on Athlon 
AM2 under test since a couple of week and it goes fine.

BUT notice: i boot from SATA, dont have any PATA disk.

Maybe u can use that waiting for the patch

Bye,

Gianluca

Marc Perkel wrote:

> Ok - I had a bad day today struggling with hardware. Having said that 
> I'm somewhat frustrated with the lack of progress of Linux getting it 
> right with Asus, nVidia, and AMD processors right.
>
> I still have to run pci=nommconf to keep the server from locking up. 
> That's with both 939 pin and AM2 motherboards.
>
> This bug remains unresolved:
>
> http://bugzilla.kernel.org/show_bug.cgi?id=6975
>
> So what's up with the no progress?
>
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



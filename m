Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271712AbTGRGOw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 02:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271719AbTGRGOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 02:14:52 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:36262 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S271712AbTGRGOt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 02:14:49 -0400
Date: Fri, 18 Jul 2003 09:24:23 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
X-X-Sender: util@hosting.rdsbv.ro
To: Jeff Garzik <jgarzik@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: libata driver update posted
In-Reply-To: <3F1711C8.6040207@pobox.com>
Message-ID: <Pine.LNX.4.53.0307180924020.19703@hosting.rdsbv.ro>
References: <3F1711C8.6040207@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Next update will add several host drivers, now that the libata API is
> settling down.

Sii3112A is/will be supported?
Thanks!

>
>
> 2.4.21-based patch:
> ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.4/2.4.21-libata4.patch.bz2
>
> 2.4.21-based BitKeeper repo:
> bk://kernel.bkbits.net/jgarzik/atascsi-2.4
>
> 2.6.0-test1-based patch:
> ftp://ftp.??.kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/2.6.0-test1-libata1.patch.bz2
>
> 2.6.0-test1-based BitKeeper repo:
> bk://kernel.bkbits.net/jgarzik/atascsi-2.5
> (yes, "2.5" is not a typo, I haven't changed the name to 2.6 yet)
>
>
> Remove the ".??" if the file has not appeared on your favorite
> kernel.org mirror yet.
>
>
> Changes:
> * beginnings of pluggable timing configuration
> * beginnings of cable detection
> * much improved ATA device probing
> * a bunch of internal improvements and cleanups (too many to list)
> * additional of DocBook documentation
> * many bug fixes
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro

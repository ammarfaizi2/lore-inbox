Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264953AbTK3ROC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 12:14:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbTK3ROC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 12:14:02 -0500
Received: from legolas.restena.lu ([158.64.1.34]:1695 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S264953AbTK3RN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 12:13:57 -0500
Subject: Re: Silicon Image 3112A SATA trouble
From: Craig Bradney <cbradney@zip.com.au>
To: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3FCA2E49.9040707@wanadoo.es>
References: <3FCA2E49.9040707@wanadoo.es>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1070212432.28187.25.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 30 Nov 2003 18:13:52 +0100
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the topic of speeds.. hdparm -t gives me 56Mb/s on my Maxtor 80Mb 8mb
cache PATA drive. I got that with 2.4.23 pre 8 which was ATA100 and get
just a little more on ATA133 with 2.6. Not sure what people are
expecting on SATA.

Craig

On Sun, 2003-11-30 at 18:52, Luis Miguel García wrote:
> hello:
> 
> I have a Seagate Barracuda IV (80 Gb) connected to parallel ata on a 
> nforce-2 motherboard.
> 
> If any of you want for me to test any patch to fix the "seagate issue", 
> please, count on me. I have a SATA sis3112 and a parallel-to-serial 
> converter. If I'm of any help to you, drop me an email.
> 
> By the way, I'm only getting 32 MB/s   (hdparm -tT /dev/hda) on my 
> actual parallel ata. Is this enough for an ATA-100 device?
> 
> Thanks a lot.
> 
> LuisMi García
> Spain
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


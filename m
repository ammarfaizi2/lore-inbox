Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265784AbUBCBdi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 20:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265800AbUBCBdi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 20:33:38 -0500
Received: from dodge.jordet.nu ([217.13.8.142]:20388 "EHLO dodge.jordet.nu")
	by vger.kernel.org with ESMTP id S265784AbUBCBdh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 20:33:37 -0500
Subject: Re: ACPI -- Workaround for broken DSDT
From: Stian Jordet <liste@jordet.nu>
To: trelane@digitasaru.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040203010258.GC6376@digitasaru.net>
References: <BF1FE1855350A0479097B3A0D2A80EE0CC8A85@hdsmsx402.hd.intel.com>
	 <20040203010258.GC6376@digitasaru.net>
Content-Type: text/plain
Message-Id: <1075771966.668.3.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 02:32:47 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tir, 03.02.2004 kl. 02.03 skrev Joseph Pingenot:
> From Brown, Len on Sunday, 01 February, 2004:
> >The vendor should supply a correct DSDT with their BIOS.
> >In the case of Dell, you might inquire here: http://linux.dell.com/
> >For non-vendor supplied solutions, you might also follow the DSDT link
> >here: http://acpi.sourceforge.net/  
> 
> Hmm.  Do vendors generally release these?  I know Dell's very shaky on
>   the Linux support front, at least for desktop/laptop.
> Also, how do non-vendor supplied ones get made?  Seems like something
>   you need NDA'ed docs for.
> 
> -Joseph

I guess it varies. Rioworks (http://www.rioworks.com) made a new BIOS
for me, after I (with very, very good help from Len Brown) told them
their DSDT was broken. :)

Best regards,
Stian


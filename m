Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161011AbWI2XSb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161011AbWI2XSb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 19:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161003AbWI2XSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 19:18:30 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:41103 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932243AbWI2XS3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 19:18:29 -0400
Subject: Re: 2.6.18-mm2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: Matthew Wilcox <matthew@wil.cx>, "J.A. Magall??n" <jamagallon@ono.com>,
       Andrew Morton <akpm@osdl.org>,
       "Linux-Kernel," <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org
In-Reply-To: <20060929235054.GB2020@slug>
References: <20060928014623.ccc9b885.akpm@osdl.org>
	 <20060929155738.7076f0c8@werewolf> <20060929143949.GL5017@parisc-linux.org>
	 <1159550143.13029.36.camel@localhost.localdomain>
	 <20060929235054.GB2020@slug>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 30 Sep 2006 00:43:24 +0100
Message-Id: <1159573404.13029.96.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-09-29 am 23:50 +0000, ysgrifennodd Frederik Deweerdt:
> Does this patch makes sense in that case? If yes, I'll put up a patch
> for the remaining cases in the drivers/scsi/aic7xxx/ directory.
> Also, aic7xxx's coding style would put parenthesis around the returned
> value, should I follow it?

Yes - but perhaps with a warning message so users know why ?

As to coding style - kernel style is unbracketed so I wouldnt worry
about either.



Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750962AbVIJOaO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750962AbVIJOaO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 10:30:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbVIJOaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 10:30:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56256 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750959AbVIJOaM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 10:30:12 -0400
Date: Sat, 10 Sep 2005 10:30:01 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@cuia.boston.redhat.com
To: Luben Tuikov <ltuikov@yahoo.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
In-Reply-To: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
Message-ID: <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sep 2005, Luben Tuikov wrote:

> No self respecting SAS chip would not do 64 bit DMA, or have an sg 
> tablesize or any other limitation.
> 
> Naturally, aic94xx has _no limitations_. :-)  But hey, our hardware just 
> kicks a*s!

That's very nice for you - but lets face it, a SAS layer
that'll be unable to also deal with the El-Cheapo brand
controllers isn't going to be very useful.

-- 
All Rights Reversed

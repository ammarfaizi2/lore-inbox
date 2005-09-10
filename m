Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932256AbVIJT5Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932256AbVIJT5Y (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 15:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVIJT5Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 15:57:24 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:19160 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932246AbVIJT5X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 15:57:23 -0400
Subject: Re: [PATCH 2.6.13 14/14] sas-class: SCSI Host glue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@redhat.com>
Cc: Luben Tuikov <ltuikov@yahoo.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
References: <20050910041218.29183.qmail@web51612.mail.yahoo.com>
	 <Pine.LNX.4.63.0509101028510.4630@cuia.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 10 Sep 2005 21:20:05 +0100
Message-Id: <1126383605.30449.12.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2005-09-10 at 10:30 -0400, Rik van Riel wrote:
> That's very nice for you - but lets face it, a SAS layer
> that'll be unable to also deal with the El-Cheapo brand
> controllers isn't going to be very useful.

If future cheap SAS controllers are like cheap anything else controllers
then it is better IMHO to deal with it once the problems are visible. We
*know* from experience that hardware limits will be weirder than the
anticipated.


Alan


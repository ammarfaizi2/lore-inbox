Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262596AbVFLN6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262596AbVFLN6m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 09:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262613AbVFLN6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 09:58:41 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:25402 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262596AbVFLN4Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 09:56:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rhfD/+7fGe1Y5aVeaoRiByTn7CXWm7zPz034B8vLvLMJO0nejWx9RAyEpjHUUSbotpR7yiHJ8L4F1lkzBcf4NTCm/kok/pLUal1BYdph83c/Ef0T4tgyv/kp5D7fwOdXQPfr8ug4lSuHFZEJBzZNR2ClBklZZrgM5bf9nRenGo8=
Message-ID: <2ff2162805061206564e7f1dc7@mail.gmail.com>
Date: Sun, 12 Jun 2005 15:56:23 +0200
From: Abhijit Bhopatkar <bainonline@gmail.com>
Reply-To: Abhijit Bhopatkar <bainonline@gmail.com>
To: "jgarzik@pentafluge.infradead.org" <jgarzik@pentafluge.infradead.org>
Subject: Re: stupid SATA questions
Cc: Robert White <rwhite@casabyte.com>, Jeff Garzik <jgarzik@pobox.com>,
       Kumar Gala <kumar.gala@freescale.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050611184746.GC3019@pentafluge.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42A72E4F.4040700@pobox.com>
	 <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAujDVGqnqiEuiX8MD6j5uVwEAAAAA@casabyte.com>
	 <20050611184746.GC3019@pentafluge.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/05, jgarzik@pentafluge.infradead.org
<jgarzik@pentafluge.infradead.org> wrote:
> On Fri, Jun 10, 2005 at 11:51:26AM -0700, Robert White wrote:
> > I cannot find the ATA passthru or SMART option in the 2.6.11.10 kernel anywhere near
> > the SCSI or ATA .  Is it somewhere obscure, has it been renamed, or am I looking in
> > totally the wrong place? (e.g. is this an option when building hdparm or something?)
> 
> It requires an additional patch; it has not been mergedsinceit still
> has a few problems.

Can somebody please point me to the latest patches?
ATA pass thru should be a good thing to play with
I am waiting for SATA ATAPI support so that finally i can start
playing DVDs again under linux.

I have ICH6M chipset with DVD/CD-RW drive on my laptop. So if you need
some testing on that i am willing to do that.

Currently i am running on 2.6.11 with JG's 
"2.6.11-libata-dev1.patch.bz2 " patch and ATAPI tunred on in libata.h,
but apparently it still is not in working condition, are there
experimental patches which have atleast half working ATAPI in libata?

Or should i just wait for some more time ?.....
Thanks and reagards,

BAIN

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUG0WYF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUG0WYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266665AbUG0WYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 18:24:05 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:20956 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S266666AbUG0WYC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 18:24:02 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Organization: Organization: undetectable
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8-rc2 crashes
Date: Tue, 27 Jul 2004 18:24:01 -0400
User-Agent: KMail/1.6
References: <200407271233.04205.gene.heskett@verizon.net> <200407271315.22075.gene.heskett@verizon.net> <20040727192615.GG12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040727192615.GG12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271824.01780.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [141.153.92.209] at Tue, 27 Jul 2004 17:24:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 July 2004 15:26, viro@parcelfarce.linux.theplanet.co.uk 
wrote:

>Doesn't help - all we know is that at some point in a cyclic list
> we'd got NULL instead of a pointer to the next list element. 
> Could've happened for any number of reasons.
>
>What filesystems do you have on that box, BTW?

All ext3 (except swap of course)

-- 
Cheers, Gene
There are 4 boxes to be used in defense of liberty. 
Soap, ballot, jury, and ammo.
Please use in that order, starting now.  -Ed Howdershelt, Author
Additions to this message made by Gene Heskett are Copyright 2004, 
Maurice E. Heskett, all rights reserved.

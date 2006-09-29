Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161371AbWI2SVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161371AbWI2SVD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 14:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161374AbWI2SVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 14:21:01 -0400
Received: from mxsf23.cluster1.charter.net ([209.225.28.223]:9650 "EHLO
	mxsf23.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S1161371AbWI2SVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 14:21:00 -0400
X-IronPort-AV: i="4.09,238,1157342400"; 
   d="scan'208"; a="653607170:sNHT63099268"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17693.25604.385866.792061@smtp.charter.net>
Date: Fri, 29 Sep 2006 14:20:52 -0400
From: "John Stoffel" <john@stoffel.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Stoffel <john@stoffel.org>, Jeff Garzik <jeff@garzik.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: SATA status reports update
In-Reply-To: <1159554243.13029.64.camel@localhost.localdomain>
References: <451CE8EC.1020203@garzik.org>
	<17693.23849.348841.607752@smtp.charter.net>
	<1159554243.13029.64.camel@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> Ar Gwe, 2006-09-29 am 13:51 -0400, ysgrifennodd John Stoffel:
Jeff> I updated the info at http://linux-ata.org/ to match the current
Jeff> code in linux-2.6.git.
>> 
>> Thanks!
>> 
Jeff> Let me know if something is missing or in error.
>> 
>> It would be nice to have more details about PATA support.  I'm hoping
>> to test my HPT302 rev1 card with 2.6.18-mm2 tonight if all goes
>> well...

Alan> I've sent Jeff so material to do that. The HPT302 is a "needs
Alan> lots of testing" case still, as is pretty much all HPT later
Alan> than the 366.

I'm happy to test that code as well, if you care to bounce me a patch
vs. 2.6.18-mm2, or any reasonably recent kernel.  My latest tests have
basically just bombed big time, with lots of errors.  

John

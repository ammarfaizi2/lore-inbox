Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964821AbVI2Thv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821AbVI2Thv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 15:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbVI2Thv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 15:37:51 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:28644 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964821AbVI2Tht (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 15:37:49 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <433C4266.7040304@s5r6.in-berlin.de>
Date: Thu, 29 Sep 2005 21:37:10 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040914
X-Accept-Language: de, en
MIME-Version: 1.0
To: SCSI Mailing List <linux-scsi@vger.kernel.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Luben Tuikov <luben_tuikov@adaptec.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com>
In-Reply-To: <4339F9A8.2030709@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.485) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
>> The sad truth is that SCSI Core knows only HCIL.
> 
> That's something that needs fixing, for SAS.

Not just for SAS.

>> The code doesn't alter Linux SCSI or anyone else's behaviour.
>> It only _provides_ SAS support to the kernel.
> 
> That's one of the problems: It should update the SCSI core.

Sure, but the same is true for the other transports except for SPI.
-- 
Stefan Richter
-=====-=-=-= =--= ===-=
http://arcgraph.de/sr/

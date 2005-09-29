Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbVI2UAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbVI2UAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 16:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964886AbVI2UAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 16:00:45 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:31718 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S964881AbVI2UAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 16:00:44 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <433C47AA.9040809@s5r6.in-berlin.de>
Date: Thu, 29 Sep 2005 21:59:38 +0200
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
References: <43384E28.8030207@adaptec.com> <4339BFE9.1060604@pobox.com> <4339CCD6.5010409@adaptec.com> <4339F9A8.2030709@pobox.com> <433AFEB2.7090003@adaptec.com> <433B0457.7020509@pobox.com> <433B14E1.6080201@adaptec.com> <433B217F.4060509@pobox.com>
In-Reply-To: <433B217F.4060509@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: (-1.486) AWL,BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
[...]
> HCIL stuff to move to SPI-specific transport code.
> 
> That is the task that must be completed BEFORE transport layer for SAS 
> can be fully merged.

So it could at least be _halfway_ merged, like it was done with the 
other non-SPI transport layers long ago, couldn't it?
-- 
Stefan Richter
-=====-=-=-= =--= ===-=
http://arcgraph.de/sr/

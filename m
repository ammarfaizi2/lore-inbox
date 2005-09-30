Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030502AbVI3Xnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030502AbVI3Xnn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 19:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030503AbVI3Xnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 19:43:43 -0400
Received: from outgoing.tpinternet.pl ([193.110.120.20]:28705 "EHLO
	outgoing.tpinternet.pl") by vger.kernel.org with ESMTP
	id S1030502AbVI3Xnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 19:43:43 -0400
In-Reply-To: <433DB5D7.3020806@adaptec.com>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>	 <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>	 <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com> <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>
Cc: andrew.patterson@hp.com, "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       dougg@torque.net, Linus Torvalds <torvalds@osdl.org>,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Marcin Dalecki <dalecki.marcin@neostrada.pl>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into the kernel
Date: Sat, 1 Oct 2005 01:42:06 +0200
To: Luben Tuikov <luben_tuikov@adaptec.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2005-10-01, at 00:01, Luben Tuikov wrote:
> Why should synchronization between Process A and Process B
> reading storage attributes take place in the kernel?
>
> They can synchronize in user space.

In a mandatory and transparent way? How?


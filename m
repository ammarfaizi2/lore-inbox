Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVJDOyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVJDOyf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 10:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbVJDOyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 10:54:35 -0400
Received: from mail.dvmed.net ([216.237.124.58]:13483 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932507AbVJDOye (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 10:54:34 -0400
Message-ID: <43429789.8020102@pobox.com>
Date: Tue, 04 Oct 2005 10:54:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luben Tuikov <luben_tuikov@adaptec.com>
CC: Linus Torvalds <torvalds@osdl.org>, Ryan Anderson <ryan@autoweb.net>,
       =?ISO-8859-1?Q?Tomasz_K=B3oczko?= <kloczek@rudy.mif.pg.gda.pl>,
       andrew.patterson@hp.com, Marcin Dalecki <dalecki.marcin@neostrada.pl>,
       "Salyzyn, Mark" <mark_salyzyn@adaptec.com>, dougg@torque.net,
       Luben Tuikov <ltuikov@yahoo.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
 the kernel
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01A9FA11@otce2k03.adaptec.com>  <1128105594.10079.109.camel@bluto.andrew>  <433D9035.6000504@adaptec.com>  <1128111290.10079.147.camel@bluto.andrew>  <433DA0DF.9080308@adaptec.com>  <1128114950.10079.170.camel@bluto.andrew> <433DB5D7.3020806@adaptec.com>  <9B90AC8A-A678-4FFE-B42D-796C8D87D65B@neostrada.pl>  <4341381D.2060807@adaptec.com>  <E93AC7D5-4CC0-4872-A5B8-115D2BF3C1A9@neostrada.pl>  <1128357350.10079.239.camel@bluto.andrew> <43415EC0.1010506@adaptec.com>  <Pine.BSO.4.62.0510032103380.28198@rudy.mif.pg.gda.pl> <1128377075.23932.5.camel@ryan2.internal.autoweb.net> <Pine.LNX.4.64.0510031531170.31407@g5.osdl.org> <434293D8.50300@adaptec.com>
In-Reply-To: <434293D8.50300@adaptec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luben Tuikov wrote:
> The reason of all this hoopla is that James B, wants to decree
> that LSI/MPT is the norm and everything else (USB/SAS/SBP) is
> the exception, while in fact it is the other way around.

False.  You continue to misunderstand basic stuff about the SCSI core.

We are trying to support all these crazy configurations... at once :)

	Jeff



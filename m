Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbUCPXfU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 18:35:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbUCPXfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 18:35:20 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:50346 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261827AbUCPXfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 18:35:16 -0500
Message-ID: <40578F31.5090700@matchmail.com>
Date: Tue, 16 Mar 2004 15:35:13 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040304)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Status HPT374 (HighPoint 1540) Sata in 2.6
References: <405786EC.5000803@matchmail.com>
In-Reply-To: <405786EC.5000803@matchmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> Hi,
> 
> The low end of the market is dominated by the SII3112 chipset, so I'm 
> looking for an alternative 4-port JBOD SATA controller and came across 
> the High Point card.
> 
> How is the support of these cards from libata and/or drivers/ide in 2.6?

Hmm, it looks like it's "supported by at latest 2.4.21-pre5", but it 
doesn't give details, or what SATA features are (or not) supported. 
Though, what Jeff said probably overrides this...

http://www.linuxmafia.com/faq/Hardware/sata.html

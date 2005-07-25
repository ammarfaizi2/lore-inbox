Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVGYVSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVGYVSH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 17:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVGYVSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 17:18:02 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:1474 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S261508AbVGYVRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 17:17:43 -0400
In-Reply-To: <17125.11156.794826.51922@cargo.ozlabs.ibm.com>
References: <17125.11156.794826.51922@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5FEDA737-A82B-46E3-859F-79558D3EB163@freescale.com>
Cc: "Christoph Hellwig" <hch@lst.de>, <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <kumar.gala@freescale.com>
Subject: Re: ping^2: [PATCH] move /proc/ppc_htab creating self-contained in arch/ppc/ code
Date: Mon, 25 Jul 2005 16:17:38 -0500
To: Paul Mackerras <paulus@samba.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jul 25, 2005, at 1:12 PM, Paul Mackerras wrote:

> Christoph Hellwig writes:
>
>
>> On Mon, Jun 27, 2005 at 11:05:02PM +0200, Christoph Hellwig wrote:
>>
>>> On Wed, May 04, 2005 at 08:44:39PM +0200, Christoph Hellwig wrote:
>>>
>>>> additional benefit is cleaning up the ifdef mess in ppc_htab.c
>>>>
>>>>
>>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
>>>>
>>>
>>> ping?
>>>
>
> I would actually rather get rid of /proc/ppc_htab altogether.

What do we need to do to get rid of it completely?

- kumar

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTICRBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 13:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263844AbTICRBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 13:01:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26560 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263784AbTICRBd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 13:01:33 -0400
Message-ID: <3F561E60.4010703@pobox.com>
Date: Wed, 03 Sep 2003 13:01:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
CC: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [bk patches] 2.4.x quick fixes
References: <20030831140543.GA4819@gtf.org> <20030831220602.GA2465@werewolf.able.es>
In-Reply-To: <20030831220602.GA2465@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
> On 08.31, Jeff Garzik wrote:
> 
>>Marcelo, please do a
>>
>>	bk pull bk://kernel.bkbits.net/jgarzik/misc-2.4
>>
>>This will update the following files:
>>
>> arch/i386/kernel/pci-irq.c |    1 +
>> drivers/pci/pci.c          |    2 +-
>> include/linux/pci.h        |    2 +-
>> 3 files changed, 3 insertions(+), 2 deletions(-)
>>
> 
> 
> Against pre2, this is missing to build the thing:
> 
> --- linux-2.4.23-pre2-jam1m/drivers/pci/pci.c.orig	2003-08-31 23:59:15.000000000 +0200
> +++ linux-2.4.23-pre2-jam1m/drivers/pci/pci.c	2003-09-01 00:00:22.000000000 +0200


Already fixed.  Check out the 2.4 BK snapshots for the fixes, until 
-pre3 is out.

Thanks,

	Jeff




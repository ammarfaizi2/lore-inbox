Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268690AbUI2RKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268690AbUI2RKS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUI2RKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:10:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42897 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268690AbUI2RHs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:07:48 -0400
Message-ID: <415AEBCE.9070507@pobox.com>
Date: Wed, 29 Sep 2004 13:07:26 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Russell King <rmk+lkml@arm.linux.org.uk>, Alan Cox <alan@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: PATCH: 3c59x 00:00:00:00:00:00 MAC failure
References: <20040929163023.GA17899@devserv.devel.redhat.com>	 <20040929174530.D16537@flint.arm.linux.org.uk> <415AE866.7090007@pobox.com> <1096473535.15905.54.camel@localhost.localdomain>
In-Reply-To: <1096473535.15905.54.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-09-29 at 17:52, Jeff Garzik wrote:
> 
>>>Shouldn't this be using is_valid_ether_addr() ?
>>
>>Yes.
> 
> 
> Fixed in my tree - want another diff ?

pretty please :)

	Jeff




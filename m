Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265474AbUFCCv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265474AbUFCCv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 22:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265478AbUFCCv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 22:51:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36302 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265474AbUFCCv5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 22:51:57 -0400
Message-ID: <40BE923F.7070601@pobox.com>
Date: Wed, 02 Jun 2004 22:51:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stuart Young <cef-lkml@optusnet.com.au>
CC: linux-kernel@vger.kernel.org, root@chaos.analogic.com,
       Markus Lidel <Markus.Lidel@shadowconnect.com>
Subject: Re: Problem with ioremap which returns NULL in 2.6 kernel
References: <40BC788A.3020103@shadowconnect.com> <40BDF1AC.7070209@shadowconnect.com> <Pine.LNX.4.53.0406021144280.559@chaos> <200406031241.27669.cef-lkml@optusnet.com.au>
In-Reply-To: <200406031241.27669.cef-lkml@optusnet.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stuart Young wrote:
> On Thu, 3 Jun 2004 01:45, Richard B. Johnson wrote:
> 
>>I asked for the output of `cat /proc/pci` . Unless I get that
>>information, I can't find the length of the allocation.
> 
> 
> Is there no way to to get this information out of lspci (eg: lspci -vv)? This 
> is particularly annoying since /proc/pci is depreciated. I know a number of 


You _can_ get that information out of lspci.

	Jeff


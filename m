Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263270AbTJBLKN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 07:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263288AbTJBLKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 07:10:13 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34440 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S263270AbTJBLKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 07:10:10 -0400
Message-ID: <3F7C077D.10004@comcast.net>
Date: Thu, 02 Oct 2003 07:09:49 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Linux 2.4.23-pre6
References: <Pine.LNX.4.44.0310020407590.2889-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0310020407590.2889-100000@dmt.cyclades>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> On Wed, 1 Oct 2003, David van Hoose wrote:
> 
> 
>>Marcelo Tosatti wrote:
>>
>>>Hi,
>>>
>>>Here goes -pre6. 
>>>
>>>It contains several ACPI fixes (the USB "not working anymore" problems in
>>>-pre5 should be gone), support for the SCTP protocol, x86-64/PPC/SH
>>>merges, network drivers update (EMAC, e1000, sk98lin), megaraid update,
>>>amongst others.
>>>
>>>Enjoy :) 
>>>
>>>Summary of changes from v2.4.23-pre5 to v2.4.23-pre6
>>>============================================
> 
> 
> Does turning ACPI off make any difference? 
> 
> Did pre4 worked?

Turning ACPI off works.
Pre4 works with ACPI.
This problem started with pre5.
I reported the problem in pre5 to ACPI-devel as per Greg Kroah's 
suggestion. Should I re-report the bug or not? It still isn't closed on 
buzilla.

-David van Hoose


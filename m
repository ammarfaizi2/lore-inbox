Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUC0BV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 20:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbUC0BVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 20:21:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16768 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261567AbUC0BVQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 20:21:16 -0500
Message-ID: <4064D6FE.7000506@pobox.com>
Date: Fri, 26 Mar 2004 20:21:02 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Andrew Morton <akpm@osdl.org>, scott.feldman@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add PCI_DMA_{64,32}BIT constants
References: <20040323052305.GA2287@havoc.gtf.org> <20040327002935.GB13097@kroah.com> <4064CDB2.10001@pobox.com> <20040327004842.GA13611@kroah.com>
In-Reply-To: <20040327004842.GA13611@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Fri, Mar 26, 2004 at 07:41:22PM -0500, Jeff Garzik wrote:
> 
>>Greg KH wrote:
>>
>>>On Tue, Mar 23, 2004 at 12:23:05AM -0500, Jeff Garzik wrote:
>>>
>>>
>>>>Been meaning to do this for ages...
>>>>
>>>>Another one for the janitors.
>>>>
>>>>Please do a
>>>>
>>>>	bk pull bk://kernel.bkbits.net/jgarzik/pci-dma-mask-2.6
>>>>
>>>>This will update the following files:
>>>
>>>
>>>Nice, I've pulled this to my pci tree and will forward it on to Linus in
>>>the next round of pci patches after 2.6.5 is out.
>>
>>Yeah well...  in the intervening time, somebody on IRC commented
>>
>>"so what is so PCI-specific about those constants?"
>>
>>They probably ought to be DMA_{32,64}BIT_MASK or somesuch.
> 
> 
> Heh, ok, care to make up another patch for this?  :)

Yeah, but not at the moment :)  So just drop it for now, I suppose.

	Jeff





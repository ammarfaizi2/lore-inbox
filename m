Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVCDFUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVCDFUY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 00:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262145AbVCDFQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 00:16:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49887 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262105AbVCDFLo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 00:11:44 -0500
Message-ID: <4227EDEC.3040606@pobox.com>
Date: Fri, 04 Mar 2005 00:11:08 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: Netdev <netdev@oss.sgi.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, philipp.gortan@tttech.com
Subject: Re: netdev-2.6 queue updated
References: <4226BD3B.9080604@pobox.com> <42277195.8@gentoo.org>
In-Reply-To: <42277195.8@gentoo.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> Jeff Garzik wrote:
> 
>> <philipp.gortan:tttech.com>:
>>   o [netdrvr 8139cp] add PCI ID
> 
> 
> This one seems to be already present in 2.6.11 under a different name 
> (PCI_DEVICE_ID_TTTECH_MC322). Also, the corresponding entry in pci_ids.h 
> is not in the order of the file.

BitKeeper will fix that up at merge time.

	Jeff




Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267745AbUJLUir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267745AbUJLUir (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 16:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267759AbUJLUir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 16:38:47 -0400
Received: from darkwing.uoregon.edu ([128.223.142.13]:19329 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id S267745AbUJLUin (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 16:38:43 -0400
Date: Tue, 12 Oct 2004 13:38:38 -0700 (PDT)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Andy Warner <andyw@pobox.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Tom Dickson <tdickson@inostor.com>,
       linux-kernel@vger.kernel.org,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: Who is working on the Marvell SATA Chipset?
In-Reply-To: <20041012152404.A14245@florence.linkmargin.com>
Message-ID: <Pine.LNX.4.61.0410121331280.11010@twin.uoregon.edu>
References: <416C2BD6.10802@inostor.com> <416C3378.6000001@pobox.com>
 <20041012152404.A14245@florence.linkmargin.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Andy Warner wrote:

> Jeff Garzik wrote:
>> Tom Dickson wrote:
>>> -----BEGIN PGP SIGNED MESSAGE-----
>>> Hash: SHA1
>>>
>>> Who is in charge of the "in progress" driver for the Marvell 88SX5040?
>>
>> I have a skeleton driver locally, need to get on to finishing it.
>
> Marvell also have drivers for 2.4 and 2.6, but they are under NDA
> etc etc, and ignore libata (they also pre-date libata), so if
> you have hardware that you _must_ get working; they might be
> a useful stopgap.
>
> I'll repeat my eagerness to test anything for the 88SX50xx or 88SX60xx,
> regardless of how primitive it is. My benchmarking with the Marvell
> driver shows the throughput to be excellent.

I would love to be buying the 8 port pci-x marvells for nas boxes where 
we're doing JBOD or software raid.

http://www.supermicro.com/products/accessories/addon/DAC-SATA-MV8.cfm

which is running around $110 at this point.


-- 
-------------------------------------------------------------------------- 
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu 
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVFBO6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFBO6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 10:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261163AbVFBO6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 10:58:07 -0400
Received: from magic.adaptec.com ([216.52.22.17]:40105 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261161AbVFBO6C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 10:58:02 -0400
Message-ID: <429F1E70.5040500@adaptec.com>
Date: Thu, 02 Jun 2005 10:57:52 -0400
From: Luben Tuikov <luben_tuikov@adaptec.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Miller, Mike (OS Dev)" <mike.miller@hp.com>
CC: "Moore, Eric Dean" <Eric.Moore@lsil.com>,
       Christoph Hellwig <hch@infradead.org>,
       Douglas Gilbert <dougg@torque.net>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Patterson, Andrew D (Linux R&D)" <andrew.patterson@hp.com>,
       Madhuresh_Nagshain@adaptec.com
Subject: Re: [RFC] SAS domain layout for Linux sysfs
References: <D4CFB69C345C394284E4B78B876C1CF107DC073C@cceexc23.americas.cpqcorp.net>
In-Reply-To: <D4CFB69C345C394284E4B78B876C1CF107DC073C@cceexc23.americas.cpqcorp.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jun 2005 14:57:43.0081 (UTC) FILETIME=[6DD26990:01C56783]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/05 10:32, Miller, Mike (OS Dev) wrote:
> Eric wrote:
> 
>>So where are we?  What needs to be done so we can move 
>>forward with getting SAS LLD support accepted by James Bottomely.
>>
>>Regards,
>>Eric Moore
> 
> 
> I think we to define the kernel objects as Christoph suggested.

I've something (sans Discover fn) and will try to tie it up
with the predefined transport classes, and with the driver
(which was using a mock up until now).

I looks exactly as the classes defined in section 4 of the
SAS draft.

	Luben

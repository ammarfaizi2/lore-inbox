Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVCIFwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVCIFwO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbVCIFwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:52:13 -0500
Received: from smtp108.mail.sc5.yahoo.com ([66.163.170.6]:58810 "HELO
	smtp108.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261450AbVCIFwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:52:09 -0500
Message-ID: <422E8EEB.7090209@yahoo.com>
Date: Tue, 08 Mar 2005 21:51:39 -0800
From: Alex Aizman <itn780@yahoo.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Matt Mackall <mpm@selenic.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE 0/6] Open-iSCSI High-Performance Initiator for Linux
References: <422BFCB2.6080309@yahoo.com> <20050309050434.GT3163@waste.org>
In-Reply-To: <20050309050434.GT3163@waste.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Mackall wrote:

>How big is the userspace client?
>  
>
Hmm.. x86 executable? source?

Anyway, there's about 12,000 lines of user space code, and growing. In 
the kernel we have approx. 3,300 lines.

>>- 450MB/sec Read on a single connection (2-way 2.4Ghz Opteron, 64KB block 
>>size);
>>    
>>
>
>With what network hardware and drives, please?
>
>  
>
Neterion's 10GbE adapters. RAM disk on the target side.

Alex

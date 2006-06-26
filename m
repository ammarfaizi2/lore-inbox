Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWFZKUg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWFZKUg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 06:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964969AbWFZKUg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 06:20:36 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:62614 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP id S964967AbWFZKUg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 06:20:36 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Expertise required:USB bulk-throughput and memory leak detection 
Date: Mon, 26 Jun 2006 15:50:18 +0530
Message-ID: <24ED22E506B5A042BF5B05B6B017D86C0A9016@PNE-HJN-MBX01.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Expertise required:USB bulk-throughput and memory leak detection 
Thread-Index: AcaY/RwvmCtC6mMIRZq67oZwS+gmAQADIa/g
From: <bhuvan.kumarmital@wipro.com>
To: <kernelnewbies@nl.linux.org>, <kernel-mentors@selenic.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jun 2006 10:20:33.0263 (UTC) FILETIME=[285E4FF0:01C6990A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 

> -----Original Message-----
> From: Bhuvan Kumarmital (WT01 - Semiconductors & Consumer 
> Electronics) 
> To: 'kernelnewbies@nl.linux.org'
> Subject: Expertise required:USB bulk-throughput and memory 
> leak detection 
> 
>  
>     My team is developing a device driver for a PCMCIA based 
> USB device. We're currently trying to test the performance of 
> our driver. However we're unable to figure out a reliable methods of:
> 1.) detecting memory leaks caused by our driver code. 
> 2.) Neither have we been able to find a tool which shows % 
> utilisation of kernel memory used by our driver.(kernel 
> memory monitoring)
> 3.) Throughput calculation of bulk data transfer is also not 
> precise. We still rely on measuring time on stop watch, while 
> Transferring data.
>  
> About the memory monitoring, there are quite a few tools 
> available at the application level (like free and top which 
> are available with the operating system itself). But none for 
> the kernel level. 
>  
> Please suggest other feasible ways of detecting leaks and 
> monitoring kernel memory utilisation for kernel 2.6.15.4 on 
> fedora core 4.
>  

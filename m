Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261237AbVGTOXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVGTOXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 10:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbVGTOXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 10:23:05 -0400
Received: from leyde.iplannetworks.net ([200.69.193.99]:51961 "EHLO
	proxy3.iplannetworks.net") by vger.kernel.org with ESMTP
	id S261237AbVGTOWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 10:22:02 -0400
Message-ID: <42DE5E7C.6060709@latinsourcetech.com>
Date: Wed, 20 Jul 2005 11:23:56 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory Management
References: <42DE4D2B.9090503@latinsourcetech.com> <1121865874.3606.13.camel@localhost.localdomain>
In-Reply-To: <1121865874.3606.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

>I'm sure RH support will be able to help you with that; I doubt many
>other people care about an ancient kernel like that, and a vendor one to
>boot.
>
>(Also I assume you are using the -hugemem kernel as the documentation
>recommends you to do)
>
>  
>
Arjan,

   I'd like to know/understand more about memory management  on  Linux 
Kernel and I belive this concept is applyable to the Red Hat Linux Kernel.

  I have some doubts about the ZONE divison (DMA, NORMAL, HIGHMEM), 
Shared Memory utilization, HugeTLB feature and OOM with large memory and 
the kernel management of memory on SMP machines. I believe these 
features are common to the Linux kernel in general(Red Hat, Debian, 
SuSe, kernel.org), right?
   I read a tons of docs regarding symposiums, The Linux Memory 
Management Book and lots of docs about Oracle memory management but 
memory management still not clear to me.

  If somebody can help me...

Thanks.



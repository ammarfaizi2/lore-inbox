Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265388AbTLRXVY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 18:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbTLRXVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 18:21:23 -0500
Received: from 64-60-248-67.cust.telepacific.net ([64.60.248.67]:52213 "EHLO
	mx.rackable.com") by vger.kernel.org with ESMTP id S265388AbTLRXVW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 18:21:22 -0500
Message-ID: <3FE2363F.70708@rackable.com>
Date: Thu, 18 Dec 2003 15:20:31 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Chandler, Neville" <chandler@ibiquity.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: non-SMP kernels fail to compile
References: <E3C9701D2F6B57468EBB36C053176EEF0172198F@mail.ibiquity.com>
In-Reply-To: <E3C9701D2F6B57468EBB36C053176EEF0172198F@mail.ibiquity.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Dec 2003 23:21:21.0479 (UTC) FILETIME=[A5A10570:01C3C5BD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chandler, Neville wrote:
> Hello,
>  
> I'm having problems compiling Non-SMP versions of the linux kernel. 
> linux-2.4.23 and linux-2.4.24-pre1 fail to compile with SMP disabled.
> However, they do compile cleanly when SMP is enabled. Any help would be
> appreciated.
> 
> Thanks.
> 
> System: Redhat 9
> GCC:    3.3.2
> 
> 


   I've compiled a number of up kernel for 2.4.23 with no issue.  What 
sort of compile errors are you getting?  Can we get you config file.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>


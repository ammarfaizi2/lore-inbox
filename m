Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbTD2TxT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 15:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbTD2TxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 15:53:19 -0400
Received: from watch.techsource.com ([209.208.48.130]:46556 "EHLO
	techsource.com") by vger.kernel.org with ESMTP id S261617AbTD2TxS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 15:53:18 -0400
Message-ID: <3EAEDB7C.9080101@techsource.com>
Date: Tue, 29 Apr 2003 16:07:24 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Swap Compression
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Con Kolivas wrote:

>On Tue, 29 Apr 2003 07:35, Timothy Miller wrote:
>  
>
>>    
>>
>The work that Rodrigo De Castro did on compressed caching 
>(linuxcompressed.sf.net) included a minilzo algorithm which I used by default 
>in the -ck patch addon as it performed the best for all the reasons you 
>mention. Why not look at that lzo code for adoption.
>
>  
>
Some time before rmoser started HIS discussion on compressed swap, I 
started a discussion on the same topic.  Out of that discussion came 
mention of an existing project which did EXACTLY what I was proposing. 
 That made me happy.  For some reason rmoser wants to start from 
scratch.  He can do that if he wants.  I had only hoped that my earlier 
mention of it would spark interest in taking the existing implementation 
and adding it to the mainline kernel, after some incompatbilities were 
dealt with.  Unfortunately, I don't have the time to engage directly in 
that particular aspect the kernel development.

>  
>


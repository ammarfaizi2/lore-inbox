Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314403AbSFXQr6>; Mon, 24 Jun 2002 12:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314422AbSFXQr6>; Mon, 24 Jun 2002 12:47:58 -0400
Received: from cwbone.bsi.com.br ([200.194.240.1]:63127 "EHLO
	cwbone.bsi.com.br") by vger.kernel.org with ESMTP
	id <S314403AbSFXQr5>; Mon, 24 Jun 2002 12:47:57 -0400
Message-ID: <3D174D3A.3060200@PolesApart.wox.org>
Date: Mon, 24 Jun 2002 13:47:54 -0300
From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.4.19-pre10-ac2 bug in page_alloc.c:131
References: <E17MUf8-00088K-00@the-village.bc.nu>	<3D173578.5080205@PolesApart.wox.org> <20020624.080409.79615643.davem@redhat.com>
X-scanner: scanned by Inflex 1.0.9 - (http://pldaniels.com/inflex/)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:

>   From: "Alexandre P. Nunes" <alex@PolesApart.wox.org>
>   Date: Mon, 24 Jun 2002 12:06:32 -0300
>   
>   Maybe I got it the wrong way, but it seems to me that from your point of 
>   view, as long as proprietary driver is in use, it's not anyone else 
>   problem but to the vendor, even if the bug could happen to be in the 
>   kernel, is that right? If so, everyone else in this list who could try 
>   to fix this (again assuming it could be something related to the kernel 
>   and not to the proprietary driver) necessarily share your oppinion? (I'm 
>   not flaming in here, just trying to get the path).
>
>This has to do with facts, not opinions.  Since we lack the source to
>their drivers, we have no idea if some bug in their driver is
>scribbling over (ie. corrupting) memory.  It is therefore an unknown
>which makes it a waste of time for us to pursue the bug report.
>  
>
Thanks, now with your report (and in fact Zwane's one, which cleared the 
fact this bug scenario have been seen before) it's all clear to me. I 
don't subscribe to nor used to read this list archives, so I couldn't 
take a better picture and guess without actually someone pointing this out.

I'll direct the pressure all over nvidia, and in mean time I'll read the 
relevant articles in the archives, which seems the way to avoid  
unnecessary redundancy ...

Sorry folks if I bothered too much, I'll try avoid that :-)

Thanks for all of you,

Alexandre



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263271AbREaW4i>; Thu, 31 May 2001 18:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263269AbREaW42>; Thu, 31 May 2001 18:56:28 -0400
Received: from mail.digitalme.com ([193.97.97.75]:53418 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S263268AbREaW4P>;
	Thu, 31 May 2001 18:56:15 -0400
Message-ID: <3B16CC23.1020202@digitalme.com>
Date: Thu, 31 May 2001 18:56:35 -0400
From: "Trever L. Adams" <vichu@digitalme.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010529
X-Accept-Language: en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.5 VM
In-Reply-To: <E155bG5-0008AX-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>My system has 128 Meg of Swap and RAM.
>>
> 
> Linus 2.4.0 notes are quite clear that you need at least twice RAM of swap
> with 2.4.
> 
> Marcelo is working to change that but right now you are running something 
> explicitly explained as not going to work as you want
> 
> 

Alan,

Actually I have tried 1x,2x,3x.  In 2.4.0 to 2.4.3 I had some issues but 
never a system freeze of any kind.  With 2.4.4 I had more problems, but 
I was ok.  2.4.5 I now have these freezes.  Maybe I should go back to 
2x, but I still find this behavior crazy.

This still doesn't negate the point of freeing simple caches.

Trever Adams


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288671AbSADPf1>; Fri, 4 Jan 2002 10:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288666AbSADPfR>; Fri, 4 Jan 2002 10:35:17 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:12562 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288671AbSADPfB>; Fri, 4 Jan 2002 10:35:01 -0500
Message-ID: <3C35CAFF.3050107@namesys.com>
Date: Fri, 04 Jan 2002 18:32:15 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Miles Lane <miles@megapathdsl.net>
CC: Andre Hedrick <andre@linux-ide.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: ATA RAID-0 FYI-Did the Impossible.
In-Reply-To: <Pine.LNX.4.10.10112310558030.4280-100000@master.linux-ide.org> <1009814128.1407.59.camel@stomata.megapathdsl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane wrote:

>On Mon, 2001-12-31 at 06:05, Andre Hedrick wrote:
>
><snip>
>
>>If you want your system to have this kind of performance, that raise hell
>>to get the patches adopted into the main kernel.
>>
>
>Have you asked Linus and Marcelo why your patches aren't being 
>accepted?  Linus and Hans Reiser eventually sorted out what 
>was required for getting reiserfs into the kernel, though it 
>took some negotiation and compromise of the part of the reiserfs
>folks.  I imagine you can do the same.
>

Um, actually I don't remember anything Linus asked for from us, probably 
he did, but if I can't remember it then it probably was not significant 
(oh wait, he asked for terseness in the licensing statements at the top 
of every file.  Surely he asked for something else also, but it was 
trivial.)

That said, Andre, if you want more testers we can put a link to your 
code on our download page, and if you want someone to read your code and 
tell you what parts aren't easy to understand (I haven't read your new 
code yet), we'll help with that also.

>
>
>It's a no-brainer that we all want fast disk I/O.
>
>	
>
That's for sure.




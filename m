Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278410AbRJVIfZ>; Mon, 22 Oct 2001 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278344AbRJVIfG>; Mon, 22 Oct 2001 04:35:06 -0400
Received: from fe170.worldonline.dk ([212.54.64.199]:47117 "HELO
	fe170.worldonline.dk") by vger.kernel.org with SMTP
	id <S278281AbRJVIe4>; Mon, 22 Oct 2001 04:34:56 -0400
Message-ID: <3BD3D867.4000907@eisenstein.dk>
Date: Mon, 22 Oct 2001 10:27:19 +0200
From: Jesper Juhl <juhl@eisenstein.dk>
Organization: Eisenstein
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.16 i586; en-US; m18) Gecko/20010131 Netscape6/6.01
X-Accept-Language: en
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated preempt-kernel
In-Reply-To: <1003562833.862.65.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

> Testers Wanted:

So I tested it :)

> patches to enable a fully preemptible kernel are available at:
> 	http://tech9.net/rml/linux
> for kernels 2.4.10, 2.4.12, 2.4.12-ac3, and 2.4.13-pre5.

I tried out your patch yesterday with 2.4.13-pre6 (it applies cleanly to 
-pre6 although made for -pre5). I've been running with it for about a 
day now and I have not seen any ill effects yet.

The system does seem slightly more responsive when stressed, but I don't 
see (or feel) huge improvements like some other people - maybe I just 
run a set of apps that don't benefit much from the preempt patches, or 
my workload is not significant enough to notice.. I usually run things 
like KDE2, XMMS, Nedit, x-cd-roast, Opera, Sylpheed and a lot of console 
windows.
This is on a 1.4Ghz Athlon Thunderbird with 512MB RAM.

Are there any tests you'd like me to try out on this box?


- Jesper Juhl - juhl@eisenstein.dk


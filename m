Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276330AbRJUQKw>; Sun, 21 Oct 2001 12:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276331AbRJUQKm>; Sun, 21 Oct 2001 12:10:42 -0400
Received: from mw3.texas.net ([206.127.30.13]:20397 "EHLO mw3.texas.net")
	by vger.kernel.org with ESMTP id <S276330AbRJUQK2> convert rfc822-to-8bit;
	Sun, 21 Oct 2001 12:10:28 -0400
Message-ID: <3BD2F350.5000107@btech.com>
Date: Sun, 21 Oct 2001 11:09:52 -0500
From: "Malcolm H. Teas" <mhteas@btech.com>
Organization: Blaze Technology, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tim Jansen <tim@tjansen.de>
CC: lgb@lgb.hu, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
In-Reply-To: <00d401c159ae$6000c7d0$5cbefea9@moya> <20011021093728.A17786@vega.digitel2002.hu> <15vI4j-1Z1VtgC@fmrl02.sul.t-online.com>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tim Jansen wrote:

> On Sunday 21 October 2001 09:37, Gábor Lénárt wrote:
> 
>>moved into kernel space :) IMHO it's strictly user space issue. You can
>>start X or gdm/xdm/kdm from a boot script and so on. No kernel modification
>>is needed for this.
>>
> 
> But what the kernel COULD do is include something like the Linux Progress 
> Patch (http://lpp.freelords.org/). It replaces the text output of the kernel 
> with graphics and a progress bar, so people are not frightened by cryptic 
> text output while booting.


But what graphics resources does the LPP require?  If it's more restricted than 
the current Linux boot process it affects server-oriented machines that aren't 
running X or graphics, that just serve resources on the net.

I'd not like to see the minimum bar for hardware compatibility raised without 
very good cause.  Boot time messages aren't a good cause for me. YMMV.

My feeling: At best it should be an option only, and default to no LPP.

-Malcolm Teas



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292550AbSBUVzB>; Thu, 21 Feb 2002 16:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292544AbSBUVyx>; Thu, 21 Feb 2002 16:54:53 -0500
Received: from imo-m04.mx.aol.com ([64.12.136.7]:51956 "EHLO
	imo-m04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S292550AbSBUVyr>; Thu, 21 Feb 2002 16:54:47 -0500
Message-ID: <3C756D06.7090901@netscape.net>
Date: Thu, 21 Feb 2002 16:56:22 -0500
From: Adam <ambx1@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
Subject: Re: driverfs question
In-Reply-To: <Pine.LNX.3.95.1020221161906.254A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



root@chaos.analogic.com wrote:

> On Thu, 21 Feb 2002, Adam wrote:
> 
>>All devices will be arranged according to type.  There will be a folder 
>>
>                                                                    ^^^^^
> 
>>Method 2:
>>Folders are created for each bus then devices are placed within them.
>>
>   ^^^^^^^
> 
> 
>>member of a pci bus, it's folder will be within the pci folder.  The 
>>
>                             ^^^^^^                        ^^^^^^
> 
> What is this? Do you mean "directory" or "file", or even "inode"?
> 
> Or is this a troll from Microsoft?  We don't have such things in
> real operating systems. Next thing you know, we'll need a "cabinet"
> to keep the "folders" in.
> 
> 
> Cheers,
> Dick Johnson
> 
> Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).
> 
>         111,111,111 * 111,111,111 = 12,345,678,987,654,321
> 
> 


You're absolutely right.  What I meant to say is a directory.  It's 
simply a bad habit.  In fact, one, of several, reason I became 
interested in the Linux kernel project is that I was unhappy with the 
Micro$oft licensing policy.  The term folder is used by micro$oft simply 
to make it's OS sound more user friendly.


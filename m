Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314373AbSDRPNH>; Thu, 18 Apr 2002 11:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314374AbSDRPNG>; Thu, 18 Apr 2002 11:13:06 -0400
Received: from adsl-62-128-214-206.iomart.com ([62.128.214.206]:9602 "EHLO
	server1.i-a.co.uk") by vger.kernel.org with ESMTP
	id <S314373AbSDRPNF>; Thu, 18 Apr 2002 11:13:05 -0400
Date: Thu, 18 Apr 2002 16:12:17 +0100
From: Andy Jeffries <lkml@andyjeffries.co.uk>
To: "Vasja J Zupan" <vasja@nuedi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HPT372 on KR7A-133R (ATA133) on production server
Message-Id: <20020418161217.5bcccbb2.lkml@andyjeffries.co.uk>
In-Reply-To: <001d01c1e6e3$c2ef1e60$b4a6a8c0@si>
Organization: Scramdisk Linux
X-Mailer: Sylpheed version 0.7.4 (Linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Apr 2002 16:16:47 +0200, "Vasja J Zupan" <vasja@nuedi.com>
wrote:
> Hi,
> I'm buying a production server for webservices for mobile operators.
> 
> My HW provider suggested Abit's KR7A-133R (ATA133)  with HPT372.
> 
> Is this motherboard already fully supported and when will stable kernel
> be ready for production use on these motherboards? (btw - any advice on
> good amd combo is appreciated)
> 
> Thank you for your help and I'd appreciate a personal cc: cos I'm not a
> member of this list.

It was crashing the Kernel, I helped a friend get his working with a patch
which he has uploaded on his website.  To date, I haven't had a reply when
I tried to ask who to submit it to on here (2.4.18 isn't fixed AFAIK).

http://www.timj.co.uk/linux/

Cheers,




-- 
Andy Jeffries
Linux/PHP Programmer
http://www.andyjeffries.co.uk/

- Windows Crash HOWTO: compile the code below in VC++ and run it!
main (){for(;;){printf("Hung up\t\b\b\b\b\b\b");}}

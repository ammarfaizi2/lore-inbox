Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbRHDDJg>; Fri, 3 Aug 2001 23:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269766AbRHDDJ2>; Fri, 3 Aug 2001 23:09:28 -0400
Received: from itvu-63-210-168-13.intervu.net ([63.210.168.13]:64904 "EHLO
	pga.intervu.net") by vger.kernel.org with ESMTP id <S268286AbRHDDJQ>;
	Fri, 3 Aug 2001 23:09:16 -0400
Message-ID: <3B6B6934.262D382A@randomlogic.com>
Date: Fri, 03 Aug 2001 20:17:08 -0700
From: "Paul G. Allen" <pgallen@randomlogic.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kplug-list@kernel-panic.org" <kplug-list@kernel-panic.org>
Subject: Re: Kernel 2.4.7 Source Code Documentation
In-Reply-To: <3B6A2CC8.7D17F96F@randomlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A slight change in plans:

www.randomlogic.com was out of disk space, so I now have a second site at http://www2.randomlogic.com. I am uploading the tar now and will uncompress the HTML
to:

http://www2.randomlogic.com/linuxkernel/

BIG NOTE READ THIS:


Anyone wishing to mirror this can download it from here:

http://www.randomlogic.com/files/linux-2.4.7_html.tar.gz

The file is in the neighborhood of 150MB and uncompressed is ~1GB. You have been forewarned. Please, no Wget on www2.randomlogic.com. :/

I'm still hoping for a better place to put it, but we'll see.

PGA

"Paul G. Allen" wrote:
> 
> I am attempting to get my slow UP PIII 800 here at work to parse the 2.4.7 source and annotate it so that I can put it up on my other web server. When it is
> done, I will upload it to the server and it should be available at this URL:
> 
> http://www.randomlogic.com/kernel/
> 
> This may or may not happen tonight since this machine is nowhere near as fast as my K7 at home and the K7 takes a few hours to do it all, but the U/L bandwidth
> is much better here (DS3 compared to cable). I do expect to have it up before the weekend.
> 
> (NOTE: I compared kernel compile times between the two, no official numbers, just compiling on both machines. I started the PIII 800 about 1 min before the K7
> Thunder. The K7 Thunder was done with make dep, bzImage, modules, and modules_install before the PIII was 50% complete with bzImage. The K7 was running 2
> SETI@Home sessions as well as compiling, the PIII was doing nothing else.)
> 
> I plan to update the documentation with every stable kernel release. (So please, don't crank them out too fast, I'd hate to spend my life U/L 1GB+ of HTML every
> other day!! ;-)
> 

-- 
Paul G. Allen
UNIX Admin II/Programmer
Akamai Technologies, Inc.
www.akamai.com
Work: (858)909-3630
Cell: (858)395-5043

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264489AbRFTC2f>; Tue, 19 Jun 2001 22:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264490AbRFTC2Z>; Tue, 19 Jun 2001 22:28:25 -0400
Received: from nycsmtp3fb.rdc-nyc.rr.com ([24.29.99.80]:13839 "EHLO nyc.rr.com")
	by vger.kernel.org with ESMTP id <S264489AbRFTC2N>;
	Tue, 19 Jun 2001 22:28:13 -0400
Message-ID: <3B300933.2090807@nyc.rr.com>
Date: Tue, 19 Jun 2001 22:23:47 -0400
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.6-pre3 i686; en-US; rv:0.9.1) Gecko/20010608
X-Accept-Language: en-us
MIME-Version: 1.0
Newsgroups: fa.linux.kernel
To: linux-kernel@vger.kernel.org
Subject: Re: How to compile on one machine and install on another?
In-Reply-To: <fa.o4pbsqv.26md2n@ifi.uio.no> <fa.go24tnv.1v60h9a@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I am trying to compile the 2.2.19 kernel one one machine for  installation
>>on another.  I believe I need to do more than just copy over  bzImage and
>>modify lilo.conf, but I don't know what.  Is there documentation somewhere
>>on how to do this?  Thanks.
>>
> 
> Other than making sure you configure it for the box it will eventually run
> on - nope you have it all sorted. If you use modules you'll want to install
> the modules on the target machine too

On a related note... is System.map also necessary?  Anyone care to explain 

what System.map does?  I have noticed that my kernel works with or 
without that file, but just figured it was a good question to ask in 
this thread.



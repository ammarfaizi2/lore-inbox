Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263753AbRFHE6O>; Fri, 8 Jun 2001 00:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263834AbRFHE6F>; Fri, 8 Jun 2001 00:58:05 -0400
Received: from [213.22.25.8] ([213.22.25.8]:24584 "EHLO vega.net.dhis.org")
	by vger.kernel.org with ESMTP id <S263753AbRFHE5n>;
	Fri, 8 Jun 2001 00:57:43 -0400
Date: Fri, 8 Jun 2001 05:56:01 +0100
To: linux-kernel@vger.kernel.org
Subject: Re: Break 2.4 VM in five easy steps
Message-ID: <20010608055601.A6609@vega.net.dhis.org>
In-Reply-To: <Pine.LNX.4.10.10106060651200.7508-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10106060651200.7508-100000@innerfire.net>
User-Agent: Mutt/1.3.18i
From: "C. Martins" <mart@vega.net.dhis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  In my everyday desktop workstation (PII 350) I have 64MB of RAM and use 300MB of swap, 150MB on 
each hard disk. After upgrading to 2.4, and maintaining the same set of applications (KDE, Netscape
& friends), the machine performance is _definitely_ much worse, in terms of responsiveness and 
throughput. Most of applications just take much longer to load, and once you've made something
that required more memory for a while (like compiling a kernel, opening a large JPEG in gimp, etc)
it takes lots of time to come back to normal. Strangely, with 2.4 the workstation just feels that
someone stole the 64MB DIMM and put in a 16MB one!!
  One thing I find strange is that with 2.4 if you run top or something similar you notice that
memory allocated for cache is almost always using more than half total RAM. I don't remember seeing
this with 2.2 kernel series...

  Anyway I think there is something really broken with respect to 2.4 VM. It is just NOT acceptable
that when running the same set of apps and type of work and you upgrade your kernel, your hardware
no longer is up to the job, when it fited perfectly right before. This is just MS way of solving
problems here.

  Best regards

 Claudio Martins 


On Wed, Jun 06, 2001 at 06:58:39AM -0700, Gerhard Mack wrote:
> 
> I have several boxes with 2x ram as swap and performance still sucks
> compared to 2.2.17.  
> 

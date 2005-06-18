Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262188AbVFRWto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262188AbVFRWto (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 18:49:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVFRWto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 18:49:44 -0400
Received: from bay104-f22.bay104.hotmail.com ([65.54.175.32]:16663 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262188AbVFRWte
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 18:49:34 -0400
Message-ID: <BAY104-F22EC810AC3D3079BA9BB2D84F70@phx.gbl>
X-Originating-IP: [65.54.175.204]
X-Originating-Email: [idht4n@hotmail.com]
In-Reply-To: <1119132601.5871.22.camel@localhost.localdomain>
From: "David L" <idht4n@hotmail.com>
To: arjanv@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: bad: scheduling while atomic!: how bad?
Date: Sat, 18 Jun 2005 15:49:33 -0700
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 18 Jun 2005 22:49:33.0654 (UTC) FILETIME=[FED90760:01C57457]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
>On Sat, 2005-06-18 at 14:59 -0700, David L wrote:
> > I'm seeing the message:
> >
> > bad: scheduling while atomic!
> >
> > I see this dozens of times when I'm writing to a nand flash device using 
>a
> > vendor-provided driver from Compulab in 2.6.8.1.  Does this mean the 
>driver
> > has a bug or is incompatible with the preemptive configuration option?  
>How
> > bad is "bad"?  Should I turn of the preemption option, ignore the 
>message,
> > or what?
>
>can you post the sourcecode of the driver? it needs fixing...
It's on-line at:

http://www.compulab.co.il/686-developer.htm

under "Linux - kernel, drivers and patches".

After unzipping, it's in:

Drivers & Patches 2.6/Flash Disk/cl_fdrv.tgz

Cheers...

                 David

_________________________________________________________________
Don’t just search. Find. Check out the new MSN Search! 
http://search.msn.click-url.com/go/onm00200636ave/direct/01/


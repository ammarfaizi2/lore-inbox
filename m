Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261710AbSJJR0u>; Thu, 10 Oct 2002 13:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261744AbSJJR0t>; Thu, 10 Oct 2002 13:26:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45580 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261710AbSJJR0s>;
	Thu, 10 Oct 2002 13:26:48 -0400
Message-ID: <3DA5B99B.5080707@pobox.com>
Date: Thu, 10 Oct 2002 13:32:11 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: linux kernel conf 0.8
References: <Pine.LNX.4.44.0210100035210.338-100000@serv> <3DA58C1E.3090102@pobox.com> <20021010192924.A13618@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> [cc: trimmed]
> 
> On Thu, Oct 10, 2002 at 10:18:06AM -0400, Jeff Garzik wrote:
> 
>>Personally I don't care about Config dependency checking...  they are 
>>not modified often enough to affect me, and even if they did, dependency 
>>checking based on changes to Config files can get ugly, AFAICS.  I just 
>>do a "bk -r co -Sq" and am done with it...
> 
> I care a lot about Config dependency checking, and you are not within the 
> group of people that I care about in this respect.
> 
> kernel-hackers has no problem realising that a "make oldconfig" is needed.
> 
> But I care about NN that follows 2.6 development, and update his/her
> tree each time a new version is posted at kernel.org.
> This group of people needs dependency checking on Config files -
> as can be seen by the number of reports that boils down to
> "run make oldconfig".


The kernel is written for people with a clue.  For people without a 
clue, they should use a vendor kernel or ESR's Aunt-Tillie-friendly system.

Dumbing-down the kernel is never the right answer.

	Jeff




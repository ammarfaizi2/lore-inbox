Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbVFWVVu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbVFWVVu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 17:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbVFWVRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 17:17:38 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:38817 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262692AbVFWVOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 17:14:09 -0400
Message-ID: <42BB261D.4070105@comcast.net>
Date: Thu, 23 Jun 2005 17:14:05 -0400
From: Ed Sweetman <safemode@comcast.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
CC: Roberto Oppedisano <roppedisano.oppedisano@gmail.com>,
       Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx> <200506231200.43671.bjorn.helgaas@hp.com> <42BB1DBD.5060808@comcast.net> <200506231455.23997.bjorn.helgaas@hp.com>
In-Reply-To: <200506231455.23997.bjorn.helgaas@hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bjorn Helgaas wrote:

>On Thursday 23 June 2005 2:38 pm, Ed Sweetman wrote:
>  
>
>>I'm tempted to go ahead and try 2.6.11, but haven't yet.
>>    
>>
>
>Please do.  If 2.6.11 works and you have any VIA devices,
>please also try the 2.6.12 patch from earlier in the thread
>and see whether that helps.
>
>  
>
it's a via motherboard, so yes, i'll be trying that patch if 2.6.11 does 
work.  It seems to make sense to try the patch first, but i had already 
removed the 2.6.12 trees i had compiled before that patch was posted.  
It takes a while for this computer to compile the kernels so i'll report 
back tonight ...  in any case, if the patch doesn't work, i'll move up 
the rc for 2.6.12 until the problem occurs, figure out what happened 
with the 8139 drivers in that patchset and hopefully see a fix. But 
first, a concert to goto.

has anyone had their problem fixed by the patch to 2.6.12?

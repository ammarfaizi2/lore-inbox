Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264260AbTEOWON (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbTEOWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:14:13 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:35313 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S264260AbTEOWON
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:14:13 -0400
Message-ID: <3EC41428.8010600@cox.net>
Date: Thu, 15 May 2003 18:26:48 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB not accepting addresses in bk9
References: <3EC310C3.9060606@cox.net> <20030515070800.GA6497@kroah.com> <3EC3F02E.1010604@cox.net> <20030515200446.GA10318@kroah.com> <3EC3F401.80507@cox.net> <20030515201742.GA10551@kroah.com>
In-Reply-To: <20030515201742.GA10551@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, May 15, 2003 at 04:09:37PM -0400, David van Hoose wrote:
> 
>>Ack. Must have accidently hit cancel rather than okay. Here it is.]
>>By the way, this is from bk10. Same config except for usb and alsa 
>>debugging options.
> 
> 
> Um, I don't see any errors in this log.  Are you sure things aren't
> working for you?

okay.. I found out after compiling and running bk4-bk8 again that the 
problem is actually in the TI Graphlink driver. The USB trackball 
doesn't give me the messages. Next time, I'll check each USB device one 
at a time and not waste anyone's time. :-/
I was just seeing the overlap in the messages.

Thanks,
David


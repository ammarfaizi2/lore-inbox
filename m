Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265415AbTLKTRC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 14:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265545AbTLKTRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 14:17:02 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:17327 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S265415AbTLKTQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 14:16:19 -0500
Message-ID: <3FD8BDAA.6010409@cyberone.com.au>
Date: Fri, 12 Dec 2003 05:55:38 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Kendall Bennett <KendallB@scitechsoft.com>
CC: Jesse Pollard <jesse@cats-chateau.net>, Linus Torvalds <torvalds@osdl.org>,
       "'Andre Hedrick'" <andre@linux-ide.org>,
       "'Arjan van de Ven'" <arjanv@redhat.com>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <3FD72F7E.4493.6296CE66@localhost> <3FD84B40.2288.66EB3B3C@localhost>
In-Reply-To: <3FD84B40.2288.66EB3B3C@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Kendall Bennett wrote:

>Jesse Pollard <jesse@cats-chateau.net> wrote:
>
>
>>>You miss my point. I was talking about a single kernel version. For a
>>>single kernel version, the ABI is both *published* and *stable*. Sure it
>>>may not be what you consider a *clean* or *good* ABI, but it *IS* an
>>>ABI. Note that:
>>>
>>>1. It is a published ABI because for that one kernel release, all the
>>>source code is available that documents the ABI (albiet badly IYO).
>>>
>>>2. It is stable because that kernel version will never change on your
>>>machine.
>>>
>>Huh? I frequently update the kernel, and the kernel minor version... as
>>well as switch from uniprocessor to SMP. The major version may not change,
>>but that minor one certanly does. And adding SMP changes the ABI for that
>>version. And patches CAN and DO change the ABI, even within the major
>>version.
>>
>
>So what? You don't change it on *MY* machine, now do you? *MY* version 
>remains stable regardless of what *YOU* do unless I update my source 
>code.
>

Linus doesn't change it on *YOUR* machine either, when he releases a new
kernel. You do when you pull his changes. The point is the difficulty from
a module distributor's point of view.



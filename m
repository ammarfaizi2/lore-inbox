Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292949AbSCELwy>; Tue, 5 Mar 2002 06:52:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292914AbSCELwp>; Tue, 5 Mar 2002 06:52:45 -0500
Received: from [195.63.194.11] ([195.63.194.11]:30732 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S292911AbSCELwa>; Tue, 5 Mar 2002 06:52:30 -0500
Message-ID: <3C84B145.90201@evision-ventures.com>
Date: Tue, 05 Mar 2002 12:51:33 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: arjanv@redhat.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.6-pre2 IDE cleanup 16
In-Reply-To: <E16i9mc-00043p-00@wagner.rustcorp.com.au> <3C84A34E.6060708@evision-ventures.com> <3C84AE16.A7F1ECCA@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> Martin Dalecki wrote:
> 
> 
>>- Disable configuration of the task file stuff. It is going to go away
>>   and will be replaced by a truly abstract interface based on
>>   functionality and *not* direct mess-up of hardware.
>>
> 
> Can we also expect a patch to remove the scb's from the scsi midlayer
> from you ?
> I mean, if a standard specifies a nice *common* command packet format
> I'd expect the midlayer
> to create such packets. Taskfile is exactly that... why removing it ?

Show me a usage of it! No please no abstract telling how usufull it
*could* be. Look at the excessive implementation code.
Look at the ATA standard and  compare this to SCSI.


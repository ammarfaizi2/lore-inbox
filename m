Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287518AbSA0CeM>; Sat, 26 Jan 2002 21:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287552AbSA0CeC>; Sat, 26 Jan 2002 21:34:02 -0500
Received: from [208.179.59.195] ([208.179.59.195]:39757 "EHLO
	Booterz.killerlabs.com") by vger.kernel.org with ESMTP
	id <S287518AbSA0Cdz>; Sat, 26 Jan 2002 21:33:55 -0500
Message-ID: <3C5366AA.90703@blue-labs.org>
Date: Sat, 26 Jan 2002 21:32:10 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7+) Gecko/20020123
X-Accept-Language: en-us
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-dj5 linking error
In-Reply-To: <Pine.LNX.4.33.0201270007010.6332-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.  Guess I'll forget about it for a bit then.

Thanks,
-d

Dave Jones wrote:

>On Sat, 26 Jan 2002, David Ford wrote:
>
>>drivers/scsi/scsidrv.o: In function `BusLogic_InterruptHandler':
>>drivers/scsi/scsidrv.o(.text+0x10d65): undefined reference to
>>`scsi_mark_host_reset'
>>
>
>That function got nuked in mainline for 2.5.1
>Looks like the BusLogic driver needs to be brought up to speed
>with the scsi/block changes.
>



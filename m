Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284176AbRLRQ2r>; Tue, 18 Dec 2001 11:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284186AbRLRQ2h>; Tue, 18 Dec 2001 11:28:37 -0500
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:3090 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S284176AbRLRQ2Y>; Tue, 18 Dec 2001 11:28:24 -0500
Message-ID: <3C1F6E8D.6070704@zk3.dec.com>
Date: Tue, 18 Dec 2001 11:27:57 -0500
From: Peter Rival <frival@zk3.dec.com>
Organization: Tru64 QMG Performance Engineering
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: bug in 2.5.1
In-Reply-To: <8A43C34093B3D5119F7D0004AC56F4BCC3441C@difpst1a.dif.dk> <3C1F305C.9030702@t-online.de> <3C1F5311.2070407@t-online.de> <20011218155357.G32511@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Tue, Dec 18 2001, Hans-Otto Ahl wrote:
> 
>>Hans-Otto Ahl wrote:
>>
>>
>>>Jesper Juhl wrote:
>>>
>>>
>>>> > Hi chaps, sorry to inform you about a problem in 'ide-floppy' drivers
>>>> > and in the module as well.
>>>>
> 
> Apply this patch
> 
> *.kernel.org/pub/linux/kernel/people/axboe/patches/v2.5/2.5.1/bio-251-1.bz2
> 
> and ide-floppy should work again.
> 
> 
Anyone have any patches for DAC960?  It doesn't compile, and I made the

"seemingly" obvious changes, but when I insmod, it sits in 
"(initializing)".  This is on an Alpha AS1200 that I'm trying to use for 
SPECsfs97 regression work...  Any ideas?

  - Pete





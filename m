Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319357AbSIFTgv>; Fri, 6 Sep 2002 15:36:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319359AbSIFTgv>; Fri, 6 Sep 2002 15:36:51 -0400
Received: from freeside.toyota.com ([63.87.74.7]:49670 "EHLO
	freeside.toyota.com") by vger.kernel.org with ESMTP
	id <S319357AbSIFTgu>; Fri, 6 Sep 2002 15:36:50 -0400
Message-ID: <3D7904DB.7070900@lexus.com>
Date: Fri, 06 Sep 2002 12:41:15 -0700
From: J Sloan <jjs@lexus.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nicholas <theunforgiven@attbi.com>
CC: Louis Garcia <louisg00@bellsouth.net>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: [OT] Re: Radeon DRM lockup
References: <1031286886.14374.9.camel@tiger> <1031338175.510.0.camel@debian>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just my $.02 -

The voodoo cards worked fine for me -
Accelerated 3D was fast and reliable -
but alas, 3dfx is no more.

I tried an ATI radeon card, which worked OK
in some scenarios, but would reliably lock the
box up solidly (no ping, no sysrq) the moment
I would start a game of wolfenstein.

Since switching to nvida cards there've been no
lockups, and performance has been great - this
on 3 different systems over the past year or so.

I always grab the NVidia driver tarball and compile
against the current kernel - I've seen way too
many horror stories with folks using the binary
rpms that nvidia also provides.

Joe

Nicholas wrote:

>On Fri, 2002-09-06 at 00:34, Louis Garcia wrote:
>  
>
>>I'm experiencing many hard lockups when playing 3D games on my RH beta
>>system. I have a Radeon 7500 card and i850 chipset. Does the latest AC
>>kernels have more recent DRM code? How can I get the latest cvs code for
>>radeon cards?
>>
>>--Lou
>>
>>
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>>the body of a message to majordomo@vger.kernel.org
>>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>Please read the FAQ at  http://www.tux.org/lkml/
>>    
>>
>
>Dude different setup i use ALI but my radeon 7500 locks up too when
>trying to do 3d (ANY 3d iincludoing glxgears) any solution ANYONE has
>would be greatly appreciated.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>


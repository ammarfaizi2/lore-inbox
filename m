Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267065AbSL3U5t>; Mon, 30 Dec 2002 15:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267068AbSL3U5n>; Mon, 30 Dec 2002 15:57:43 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:47366
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S267065AbSL3U5j>; Mon, 30 Dec 2002 15:57:39 -0500
Message-ID: <3E10B538.3020408@rackable.com>
Date: Mon, 30 Dec 2002 13:06:00 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       "Justin T. Gibbs" <gibbs@scsiguy.com>,
       Janet Morgan <janetmor@us.ibm.com>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <3E03BB0D.5070605@rackable.com> <Pine.LNX.4.50L.0212280331110.30646-100000@freak.distro.conectiva> <20021228091608.GA13814@louise.pinerecords.com> <Pine.LNX.4.50L.0212281131580.26879-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Dec 2002 21:05:57.0340 (UTC) FILETIME=[3F7209C0:01C2B047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

>On Sat, 28 Dec 2002, Tomas Szepe wrote:
>
>  
>
>>Marcelo, you've been overlooking these updates for a bit too long now
>>for your "let's throw them at -ac" to sound fair.  IMHO of course.  Also
>>remember those are both production drivers tested thoroughly in FreeBSD,
>>    
>>
>
>Are we talking about the old or the new aic7xxx driver ?
>
>If it's the new driver, it's breaking on WAY too many
>machines and I have no idea why it got ever merged...
>  
>

  Well it might have had sometime to do with the way the old driver 
tended to lockup under heavy load.

>I have yet to see a machine where the new aic7xxx driver
>works. I'm sure they exist, but it doesn't work on any
>of the machines I have access to.
>
>  
>

  Funny the reverse is true for me .  It works for every system I have 
access to.

-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>




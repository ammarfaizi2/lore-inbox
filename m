Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316617AbSE3NVG>; Thu, 30 May 2002 09:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSE3NVF>; Thu, 30 May 2002 09:21:05 -0400
Received: from [195.63.194.11] ([195.63.194.11]:59406 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S316617AbSE3NVE>; Thu, 30 May 2002 09:21:04 -0400
Message-ID: <3CF6197A.9030306@evision-ventures.com>
Date: Thu, 30 May 2002 14:22:18 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vojtech Pavlik <vojtech@suse.cz>,
        Gerald Champagne <gerald@io.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 IDE 73
In-Reply-To: <1022698033.12888.279.camel@irongate.swansea.linux.org.uk>  <1022680784.2945.24.camel@wiley> <3CF4D19F.9080402@evision-ventures.com> <20020529183343.A19610@ucw.cz> <3CF4F7E8.2020300@evision-ventures.com> <12607.1022748536@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On the subject of blacklists -- when downgrading the speed of a drive 
> because it's found a blacklist, or indeed for any other reason, please 
> _print_ the reason for doing so. 
> 
> I have drives which work fine at UDMA66, but which some kernels randomly 
> refuse to configure above UDMA33 without telling me why. 

Which are those ones on which controller configuration?

> 
> Basically, any time you run a drive at a transfer speed lower than the 
> minimum of the drive's and host's listed capabilities, you should say why 
> you're doing so. 

Sure just let do one steop after other OK.



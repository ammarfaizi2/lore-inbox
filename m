Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267025AbSL3SY2>; Mon, 30 Dec 2002 13:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267026AbSL3SY2>; Mon, 30 Dec 2002 13:24:28 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:2760 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id <S267025AbSL3SY0>; Mon, 30 Dec 2002 13:24:26 -0500
Message-ID: <3E10A067.9080809@hannes-reinecke.de>
Date: Mon, 30 Dec 2002 20:37:11 +0100
From: Hannes Reinecke <mail@hannes-reinecke.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>
CC: Markus Pfeiffer <profmakx@profmakx.org>, Sam Ravnborg <sam@ravnborg.org>,
       Larry McVoy <lm@work.bitmover.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha port still maintained in 2.5
References: <Pine.LNX.4.44.0212301915070.10908-100000@gfrw1044.bocc.de>
In-Reply-To: <Pine.LNX.4.44.0212301915070.10908-100000@gfrw1044.bocc.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Friedrich wrote:
> Hi Markus,
> 
> 
>>Anyway, I just installed BitKeeper and start finding my way into the code...
> 
> 
> Maybe setting up an own repository (like the parisc, mips, m68k, etc
> people currently do using CVS) would also be a good idea, just to test out
> stuff before pushing it into the main tree and to have a common code base
> to work on.
> 
> This way we could apply e.g. the module patch from kernel.org and fix the
> remaining parts.
> 
I'm all for it. The important bit would be to get those who really 
matter (i.e. Richard Henderson, Ivan K. et al) to cooperate with it.

Otherwise it's just a waste of time, since in doubt their patches have a 
far better chance being incorporated into the main tree than ours ...

> just my 0,02 EURO
> --jochen
Same here.

Cheers,

Hannes




Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSIHTXI>; Sun, 8 Sep 2002 15:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSIHTXI>; Sun, 8 Sep 2002 15:23:08 -0400
Received: from mercury.it.wmich.edu ([141.218.1.92]:53469 "EHLO
	mercury.localmail") by vger.kernel.org with ESMTP
	id <S313628AbSIHTXH>; Sun, 8 Sep 2002 15:23:07 -0400
Message-ID: <3D7BA4BC.5050904@wmich.edu>
Date: Sun, 08 Sep 2002 15:27:56 -0400
From: Ed Sweetman <ed.sweetman@WMICH.EDU>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Nuitari <nuitari@balthasar.nuitari.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
References: <Pine.LNX.4.44.0209082126400.16694-100000@balthasar.nuitari.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nuitari wrote:
> On Sun, 8 Sep 2002 jbradford@dial.pipex.com wrote:
> 
>>I have *never* lost data to a Maxtor disk.  I have had IBM, Fujitsu, Western Digital, and DEC drives all fail on me before.
>>
>>It's dissapointing that Maxtor are reducing their warranty from 3 years to 1 year, but on the other hand, I've never needed it at all.
> 
> 
> The problem is that you will eventually lose data. No matter what the 
> brand is. Some disks tend to work better for longer time. Sometimes you 
> are just out of luck. With some brands, luck seems to be running out 
> (Quantum). Other brands may work better, but they will eventually fail.
> 
> I've had failed Seagate, Maxtor, IBM, Fujitsu, Western Digital, Quantum, 
> Conner.
> 
> The only brand which never failed that I use is Samsung (probably due to 
> the fact that I only have 2 of them compared to the other brands).
> 
> I do expect them to fail and I have backups of the most important stuff I 
> need.
> 
> The best I found for reliability (except for backups) is haveing a 
> software raid 5 on many disks of about same capacity (but different 
> brand/model).
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

well since most hdd's have a 5-10 year lifespan when operating in <30C 
you can see why many people's hdds are dying or having errors much 
sooner.  People are operating their hdd's in the mid 30's or higher due 
to low air circulation or just generally high ambient temperatures in 
the case.  This cuts run to error time significantly.   There was a 
chart on some hdd website that showed how long you can expect to have 
your data safe for different ranges of temperatures and it's something 
like 30-33 = 3 year ...~35C is getting close to 1 year and it just goes 
like that.  So yea, it's not surprising at all that reputations that 
used to work dont anymore as heat effects all and heat has become the 
dominating problem in today's hdds rather than simple quality of parts.

Keep your drive cool and you can expect to keep it around for a very 
long time.


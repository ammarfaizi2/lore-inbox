Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUADT6H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 14:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbUADT6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 14:58:07 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:54705 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S262730AbUADT6D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 14:58:03 -0500
Message-ID: <3FF8703D.8070707@blue-labs.org>
Date: Sun, 04 Jan 2004 14:57:49 -0500
From: David Ford <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20031222
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: gaim problems in 2.6.0
References: <20040104172535.GA322@elf.ucw.cz> <1073242263.3764.6.camel@twins>
In-Reply-To: <1073242263.3764.6.camel@twins>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# uname -r
2.6.1-rc1

# ps aux|grep gaim
david    12511  0.1  2.7 28392 14124 ?       S    Jan03   1:14 gaim

# gaim --version
Gaim 0.74

Not saying gaim is perfect... but it's at least running here.  
Notwithstanding the frequent quirks of preferences randomly changing on 
you..

-d

Peter Zijlstra wrote:

>Hi,
>
>every since I started using 2.6; currently running 2.6.1-rc1 gaim fails
>to start, all it does it dump core. I haven't spend time on looking
>where though.
>
>Peter Zijlstra
>
>On Sun, 2004-01-04 at 18:25, Pavel Machek wrote:
>  
>
>>Hi!
>>
>>I'm having bad problems with gaim... When I run gaim, my machine tends
>>to freeze hard (no blinking leds). I'm running vesafb -> that should
>>rule out X problems. Machine is rather strange pre-production athlon64
>>noteook, but I'm running 32-bit (on 32-bit kernel), and I can run gaim
>>under 2.4.X kernel.
>>
>>[Ugh, I was running with kgdb, but I recall same problem before, too.]
>>
>>Does anyone have similar problem?
>>								Pave
>>
>l
>  
>

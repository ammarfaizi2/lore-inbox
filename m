Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbTEKABr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 20:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbTEKABr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 20:01:47 -0400
Received: from lakemtao02.cox.net ([68.1.17.243]:8596 "EHLO lakemtao02.cox.net")
	by vger.kernel.org with ESMTP id S264531AbTEKABm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 20:01:42 -0400
Message-ID: <3EBD95CB.9010004@cox.net>
Date: Sat, 10 May 2003 19:14:03 -0500
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Norbert Wolff <norbert_wolff@t-online.de>
CC: Andy Pfiffer <andyp@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: ALSA busted in 2.5.69
References: <fa.j6n4o02.sl813a@ifi.uio.no>	<fa.juutvqv.1inovpj@ifi.uio.no>	<3EBBF00D.8040108@hotmail.com>	<1052507530.15922.37.camel@andyp.pdx.osdl.net> <20030510080440.3446cc96.norbert_wolff@t-online.de>
In-Reply-To: <20030510080440.3446cc96.norbert_wolff@t-online.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norbert Wolff wrote:
> On 09 May 2003 12:12:10 -0700
> Andy Pfiffer <andyp@osdl.org> wrote:
> 
> 
>>I'm not using devfs, and I've had no luck getting ALSA to work on my
>>i810-audio system.  OSS works fine.
>>
>>Is there a step-by-step writeup available for morons like me that
>>haven't gotten ALSA working?
> 
> 
> Hi Andy !
> 
> The Problem seems to be that ALSA has moved their devices some weeks ago.
> In the alsa-driver-0.9.3a-Package (ftp://ftp.alsa-project.org) is a script
> called snddevices (attached) which creates the needed devices and links.
> 
> Execute it as root and all should be fine ...
> 
> Maybe this Script should be distributed with the Kernel too ?

Will I have any problems if I run this script even though I'm using ALSA 
0.9.2 with 2.4.21-rc2 and whatever version is in 2.5.69-bk4?

Thanks,
David


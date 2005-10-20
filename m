Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750879AbVJTSoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750879AbVJTSoy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 14:44:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750862AbVJTSoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 14:44:54 -0400
Received: from baldrick.bootc.net ([83.142.228.48]:54242 "EHLO
	baldrick.bootc.net") by vger.kernel.org with ESMTP id S1750793AbVJTSox
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 14:44:53 -0400
Message-ID: <4357E5A1.8000301@bootc.net>
Date: Thu, 20 Oct 2005 19:44:49 +0100
From: Chris Boot <bootc@bootc.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051014)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 lockups (no oops)
References: <43567D80.3050304@bootc.net>	<20051020131815.GI2811@suse.de>	<20051020163425.z7wygjyir8lcw0gk@horde.fusednetworks.co.uk>	<20051020162112.GT2811@suse.de>	<4357C56B.30600@bootc.net> <17239.55622.86540.438878@gargle.gargle.HOWL>
In-Reply-To: <17239.55622.86540.438878@gargle.gargle.HOWL>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita Danilov wrote:

>Chris Boot writes:
>
>[...]
>
> > Oh! Hehe, now I get you. However, I'm using metalog for logging, and 
> > modprobe loop doesn't give any output. What's interesting is that serial 
> > console logging dies long before metalog is started, just after my swap 
> > is added in fact. I'm using Gentoo.
> > 
> > Any ideas?
>
>What
>
>cat /proc/sys/kernel/printk
>
>shows after a boot?
>
> > 
> > Cheers,
> > Chris
>
>Nikita.
>  
>
Hi there,

It shows:

arcadia ~ # cat /proc/sys/kernel/printk
1       4       1       7

Cheers,
Chris

-- 
Chris Boot
bootc@bootc.net
http://www.bootc.net/


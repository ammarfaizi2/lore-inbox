Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVJAN1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVJAN1S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 09:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750808AbVJAN1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 09:27:18 -0400
Received: from math.ut.ee ([193.40.36.2]:46539 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S1750807AbVJAN1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 09:27:18 -0400
Date: Sat, 1 Oct 2005 16:27:01 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Jason Munro <jason@stdbev.com>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>, adobriyan@gmail.com
Subject: Re: snd-usb-audio modpost warnings
In-Reply-To: <0bb8a8210bf8b3b9b02fbb8625deb58e@stdbev.com>
Message-ID: <Pine.SOC.4.61.0510011625410.2459@math.ut.ee>
References: <Pine.SOC.4.61.0509161002560.22187@math.ut.ee>           
 <20050917103614.GA6956@mipter.zuzino.mipt.ru>           
 <9b589152e27635af5f737b30db0fc812@stdbev.com> <0bb8a8210bf8b3b9b02fbb8625deb58e@stdbev.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>     MODPOST
>>>>   *** Warning: "__compound_literal.200" [sound/usb/snd-usb-audio.ko]
>>>>   undefined!
[...]
> Interestingly downgrading the Debian unstable gcc packages from 4.0.1-7 to
> 4.0.1-6 fixes the undefined warning problems with snd-usb-audio. Debian
> package bug?

Yes, and it is fixed with todays Debian gcc update, 4.0.2-1. Case 
closed.

-- 
Meelis Roos (mroos@linux.ee)

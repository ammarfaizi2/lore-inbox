Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263783AbUCXRNs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 12:13:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUCXRNs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 12:13:48 -0500
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:49909 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S263783AbUCXRNl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 12:13:41 -0500
Message-ID: <4061C3E5.8070307@am.sony.com>
Date: Wed, 24 Mar 2004 09:22:45 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: Bloat report 2.6.3 -> 2.6.4
References: <20040312204458.GJ20174@waste.org> <20040312152206.61604447.akpm@osdl.org> <20040312235349.GK20174@waste.org> <20040313170839.GV14833@fs.tum.de> <20040313173331.GO20174@waste.org> <20040313175712.GY14833@fs.tum.de>
In-Reply-To: <20040313175712.GY14833@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Sat, Mar 13, 2004 at 11:33:32AM -0600, Matt Mackall wrote:
>>But I think it's fair to say that new features that are on by default
>>are in fact bloat in some sense.
> 
> Perhaps in some sense, but not in any interesting sense.
> 
> For the average computer you can buy at your supermarket today it isn't 
> very interesting whether the kernel is bigger by 1 MB or not.
> 
> People who need to care about the size of the kernel [1] use hand-tuned 
> .config's that are far away from defconfig - and those people wouldn't 
> enable unneeded features that are on by default.
> 
> You use a metric "size increase of a defconfig kernel [2]", and I simply 
> claim that this metric doesn't measure anything useful for practical 
> purposes.

Well maybe the bloat meter is helpful for identifying bloated
features that the kernel developers added to the default configs,
so embedded guys can know to avoid them, or, if they're
interesting, try to unbloat.

Even hand tuners can use some help.  The kernel is vast and
progress is fast.  (Didn't mean to make a ryhme... ;)

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================


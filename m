Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266697AbUGLD3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266697AbUGLD3E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 23:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266702AbUGLD3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 23:29:04 -0400
Received: from ENGR.ORST.EDU ([128.193.40.2]:15355 "EHLO engr.orst.edu")
	by vger.kernel.org with ESMTP id S266697AbUGLD3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 23:29:02 -0400
From: Eric Altendorf <EricAltendorf@orst.edu>
Reply-To: EricAltendorf@orst.edu
To: Jan Rychter <jan@rychter.com>
Subject: Re: [PATCH] swsusp bootsplash support
Date: Sun, 11 Jul 2004 20:21:37 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <20040708110549.GB9919@linux.nu> <20040709155614.GA8426@linux.nu> <m21xjh1gul.fsf@tnuctip.rychter.com>
In-Reply-To: <m21xjh1gul.fsf@tnuctip.rychter.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407112021.37153.EricAltendorf@orst.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 July 2004 06:43, Jan Rychter wrote:
...
> upgrade kernels, you don't much care. But if you use a laptop and
> you actually care about opening it and getting a stable, working
> environment within 20s, trust me -- software suspend becomes more
> important to you than all the scheduler improvements in the world.
>
> I would gladly trade all the performance improvements of the last
> couple of years for a stable, working swsusp2 and a USB subsystem
> which doesn't a) prohibit my CPU from using C3 sleep and b) crash
> and burn regularly bringing the whole machine down with it.

I'll second this.  I moved to 2.6 because I needed a slew of drivers 
that were difficult to patch into 2.4 or out of date or etc.  
However, I haven't had a working 2.6 swsusp for probably 4 months or 
so (since I stopped using the 2.6.3 version after it ate my ext3 
journal on my root partition).

I suppose I could look at going back to 2.4....

-- 
Eric Altendorf    //    http://www.speedtoys.com/~eric

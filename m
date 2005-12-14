Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932301AbVLNK5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932301AbVLNK5R (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 05:57:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932399AbVLNK5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 05:57:17 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:8126 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932301AbVLNK5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 05:57:16 -0500
Date: Wed, 14 Dec 2005 11:57:23 +0100
From: Sander <sander@humilis.net>
To: Willy Tarreau <willy@w.ods.org>
Cc: Caroline GAUDREAU <caroline.gaudreau.1@ens.etsmtl.ca>,
       linux-kernel@vger.kernel.org, coywolf@gmail.com
Subject: Re: bugs?
Message-ID: <20051214105723.GA25166@favonius>
Reply-To: sander@humilis.net
References: <439F79CE.6040609@ens.etsmtl.ca> <20051214024316.GG15993@alpha.home.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051214024316.GG15993@alpha.home.local>
X-Uptime: 11:17:14 up 26 days, 21:40, 19 users,  load average: 1.05, 1.11, 1.16
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote (ao):
> On Tue, Dec 13, 2005 at 08:47:58PM -0500, Caroline GAUDREAU wrote:
> > my cpu is 1400MHz, but why there's cpu MHz         : 598.593
> > 
> > caro@olymphe:~$ cat /proc/cpuinfo
> > processor       : 0
> > vendor_id       : GenuineIntel
> > cpu family      : 6
> > model           : 9
> > model name      : Intel(R) Pentium(R) M processor 1400MHz
> > stepping        : 5
> > cpu MHz         : 598.593
> > cache size      : 1024 KB
> 
> It's probably a notebook that you started unplugged from the mains
> power. Mine is stupid enough to believe that I *want* to save power if
> I plug the mains *after* powering it up ! And there's no way to force
> it to switch from 600 to nominal freq afterwards ! So I have to
> connect it to the mains first.

If you say this based on 'cat /proc/cpuinfo' output: isn't it true that
/proc/cpuinfo is static, and doesn't necessarily reflect the actual
speed of the processor?

-- 
Humilis IT Services and Solutions
http://www.humilis.net

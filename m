Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262555AbTJJIBH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262574AbTJJIBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:01:07 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:8647 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262555AbTJJIBF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:01:05 -0400
Date: Fri, 10 Oct 2003 10:01:00 +0200
From: Jens Axboe <axboe@suse.de>
To: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: [2.7 "thoughts"] V0.3
Message-ID: <20031010080100.GO1232@suse.de>
References: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9B4591FDBACD411B01E00508BB33C1B01F24E98@mesadm.epl.prov-liege.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10 2003, Frederick, Fabian wrote:
> 2.7 "thoughts"
> Thanks to Gabor, Stuart, Stephan and others
> Don't hesitate to send me more or comment.

Please, do we really have to look at this from now and until 2.7 opens?
If I see more nice "features" from people that are never going to write
them anyways, I think I'll scream.

> * Software RAID 0+1 perhaps?
>                 A lot of hardware RAID cards support it, why not the
>                 kernel?  By RAID 0+1 I mean mirror-RAIDing two (or more)
>                 stripe-RAID arrays.  (Or can this be done already?)

What's wrong with raid X on top of raid Y? IOW, this works perfectly
fine since, hang on, 2.2 + new raid.

-- 
Jens Axboe


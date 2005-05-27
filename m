Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVE0HIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVE0HIj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVE0HGL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:06:11 -0400
Received: from math.ut.ee ([193.40.36.2]:64970 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261918AbVE0HBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:01:39 -0400
Date: Fri, 27 May 2005 10:01:26 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Jens Axboe <axboe@suse.de>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: ide-cd problem in 2.6.12-rc5 + todays snapshot
In-Reply-To: <20050527062155.GG1435@suse.de>
Message-ID: <Pine.SOC.4.61.0505271001050.29054@math.ut.ee>
References: <Pine.SOC.4.61.0505261816190.28439@math.ut.ee> <20050526171425.GX1419@suse.de>
 <20050527062155.GG1435@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Seems we do need finer granularity setting of alignment/length
>> restrictions.
>
> BTW Meelis, any chance you can change that 3 into a 15 for testing
> purposes?

15 seems to work fine.

-- 
Meelis Roos (mroos@linux.ee)

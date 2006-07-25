Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWGYTVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWGYTVt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 15:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWGYTVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 15:21:49 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17224 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964826AbWGYTVs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 15:21:48 -0400
Date: Tue, 25 Jul 2006 21:21:38 +0200
From: Jens Axboe <axboe@suse.de>
To: gmu 2k6 <gmu2006@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
Message-ID: <20060725192138.GD4044@suse.de>
References: <f96157c40607250128h279d6df7n8e86381729b8aa97@mail.gmail.com> <20060725080807.GF4044@suse.de> <f96157c40607250217o1084b992u78083353032b9abc@mail.gmail.com> <f96157c40607250220h13abfd6av2b532cae70745d2@mail.gmail.com> <f96157c40607250235t4cdd76ffxfd6f95389d2ddbdc@mail.gmail.com> <20060725112955.GR4044@suse.de> <f96157c40607250547m5af37b4gbab72a2764e7cb7c@mail.gmail.com> <20060725125201.GT4044@suse.de> <f96157c40607250750n5aa08856jbe792b0e66fb814b@mail.gmail.com> <f96157c40607251158x29f9632ey85d371a1a5a074b8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f96157c40607251158x29f9632ey85d371a1a5a074b8@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25 2006, gmu 2k6 wrote:
> thanks Jens,
> 7b30f09245d0e6868819b946b2f6879e5d3d106b
> http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=7b30f09245d0e6868819b946b2f6879e5d3d106b
> has fixed the problem (maybe together with the other 3 changes in HEAD
> as the 2nd patch in this thread did not work in the first place or maybe
> it is a little bit different, no time to check right now).

It's an identical change, so the one sent you should work as well.
Perhaps you botched that one test? These things happen, it's happened to
me as well :-)

The change definitely fixed it for me.

-- 
Jens Axboe


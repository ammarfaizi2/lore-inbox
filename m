Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285151AbRLGKLE>; Fri, 7 Dec 2001 05:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284037AbRLGKKy>; Fri, 7 Dec 2001 05:10:54 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:32517 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S284034AbRLGKKk>; Fri, 7 Dec 2001 05:10:40 -0500
Date: Fri, 7 Dec 2001 13:10:15 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new bio: compile fix for alpha
Message-ID: <20011207131015.A3736@jurassic.park.msu.ru>
In-Reply-To: <20011129165456.A13610@jurassic.park.msu.ru> <20011129152339.M10601@suse.de> <20011206204330.A608@jurassic.park.msu.ru> <20011206182318.GI4996@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011206182318.GI4996@suse.de>; from axboe@suse.de on Thu, Dec 06, 2001 at 07:23:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 06, 2001 at 07:23:18PM +0100, Jens Axboe wrote:
> Applied, although I think we'll make BUG_ON a kernel generic and not
> platform specific as per Rusty's patch.

Agreed, this would be better.

Ivan.

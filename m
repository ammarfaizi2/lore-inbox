Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272295AbRIOMbD>; Sat, 15 Sep 2001 08:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272299AbRIOMax>; Sat, 15 Sep 2001 08:30:53 -0400
Received: from mail.intrex.net ([209.42.192.246]:26383 "EHLO intrex.net")
	by vger.kernel.org with ESMTP id <S272295AbRIOMan>;
	Sat, 15 Sep 2001 08:30:43 -0400
Date: Sat, 15 Sep 2001 08:32:36 -0400
From: jlnance@intrex.net
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lazy umount (1/4)
Message-ID: <20010915083236.A9271@bessie.localdomain>
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0109141427070.11172-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Fri, Sep 14, 2001 at 03:01:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 14, 2001 at 03:01:26PM -0400, Alexander Viro wrote:

> convenient when you are doing fs hacking ;-)  Actually I've got into
> a habit of using that instead of normal umount in all cases except
> the shutdown scripts - works just fine (for obvious reasons in case
> of shutdown non-lazy behaviour is precisely what we want).

Why not shutdown?  This is the place I think it would help me the most.

Thanks,

Jim

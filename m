Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270573AbRHITmI>; Thu, 9 Aug 2001 15:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270570AbRHITle>; Thu, 9 Aug 2001 15:41:34 -0400
Received: from guestpc.physics.umanitoba.ca ([130.179.72.122]:56837 "EHLO
	mobilix.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S270568AbRHITlD>; Thu, 9 Aug 2001 15:41:03 -0400
Date: Thu, 9 Aug 2001 14:41:15 -0500
Message-Id: <200108091941.f79JfFa05834@mobilix.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keep devfs partition nodes in sync with block device drivers
In-Reply-To: <02b101c120ff$8d2b2990$6baaa8c0@kevin>
In-Reply-To: <02b101c120ff$8d2b2990$6baaa8c0@kevin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming writes:
> (I'm resending this again... Richard Gooch raised some points last
> time, but I think I adequately answered those.

Just because I haven't responded yet doesn't mean I agree. I am still
not happy with this approach. Some other approach is needed. I have
some ideas, but haven't had the chance to sit and think about it.

> There does not appear to be a "cleaner" solution to implement during
> 2.4, unless I've missed something obvious)

Please don't keep trying to force this patch in. I will get to it in
the fullness of time, but I'm travelling at the moment.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca

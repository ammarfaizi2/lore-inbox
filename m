Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271283AbRHTPyl>; Mon, 20 Aug 2001 11:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271319AbRHTPyb>; Mon, 20 Aug 2001 11:54:31 -0400
Received: from dandelion.com ([198.186.200.2]:20232 "EHLO dandelion.com")
	by vger.kernel.org with ESMTP id <S271283AbRHTPyT>;
	Mon, 20 Aug 2001 11:54:19 -0400
Date: Mon, 20 Aug 2001 08:54:32 -0700
Message-Id: <200108201554.f7KFsW707585@dandelion.com>
From: "Leonard N. Zubkoff" <lnz@dandelion.com>
To: adam@yggdrasil.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <20010820073716.A329@baldur.yggdrasil.com> (adam@yggdrasil.com)
Subject: Re: PATCH: linux-2.4.9/drivers/block/DAC960.c to new module_{init,exit} interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Date: Mon, 20 Aug 2001 07:37:16 -0700
  From: "Adam J. Richter" <adam@yggdrasil.com>

	  The following patch moves linux-2.4.9/drivers/block/DAC960.c
  to the new module_{init,exit} interface, simplifying it slightly and
  removing the DAC960_init reference from drivers/block/genhd.c
  (part of my effort to eliminate genhd.c).

I don't see any patch present as part of this message...

	  Leonard, does this look OK to you?  If so, do you want to
  submit this to Alan and Linus or do you want me to?

I have a new driver release alsmost ready, so I'll look your patch over and
merge it with my working copy, and then I'll send that update in.

		Leonard

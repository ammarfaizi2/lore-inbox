Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317429AbSGIVqY>; Tue, 9 Jul 2002 17:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317432AbSGIVqX>; Tue, 9 Jul 2002 17:46:23 -0400
Received: from front2.mail.megapathdsl.net ([66.80.60.30]:22286 "EHLO
	front2.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S317429AbSGIVqS>; Tue, 9 Jul 2002 17:46:18 -0400
Subject: Re: [PATCH] 2.4 IDE core for 2.5
From: Miles Lane <miles@megapathdsl.net>
To: Jens Axboe <axboe@suse.de>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <20020709112054.GB9551@suse.de>
References: <20020709102249.GA20870@suse.de>
	 <200207091313.07199.roy@karlsbakk.net>  <20020709112054.GB9551@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1026250991.27696.1.camel@turbulence.megapathdsl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 09 Jul 2002 14:43:12 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-09 at 04:20, Jens Axboe wrote:
> On Tue, Jul 09 2002, Roy Sigurd Karlsbakk wrote:
> > hi
> > 
> > Should I add IDE9[4567] as well, or does these ones include previous IDE 
> > pathes?
> 
> Well, the whole point of this patch set is _not_ to use the 2.5 ide core
> for now. When configuring your kernel, you get the choice of using
> 2.4-ide or 2.5-ide. If you choose 2.5-ide, then yes you should add those
> patches (I guess). If you choose 2.4-ide (which most users of the patch
> set would do, why else apply it?!), then it doesn't matter.

Thankyou Jens,

It is really quite perturbing to think how much the IDE instability
has held back development of other features in the unstable kernel.
The warm reception of your patch speaks volumes.

	Miles


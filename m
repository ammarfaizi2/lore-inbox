Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269669AbRHDQGu>; Sat, 4 Aug 2001 12:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269115AbRHDQGj>; Sat, 4 Aug 2001 12:06:39 -0400
Received: from [213.96.224.204] ([213.96.224.204]:39431 "EHLO manty.net")
	by vger.kernel.org with ESMTP id <S268913AbRHDQG3>;
	Sat, 4 Aug 2001 12:06:29 -0400
Date: Sat, 4 Aug 2001 18:06:36 +0200
From: Santiago Garcia Mantinan <manty@manty.net>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <andrewm@uow.edu.au>
Subject: 3c59x problems solved
Message-ID: <20010804180636.A3189@man.beta.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I had similar problems to those reported on LKML by Parag Warudkar on a
message on the 21st of July. I have a 3c905C and run 2.4.7, I have applied
the patch sent by Andrew to the list on reply and works ok, I'm not using
any dhcp but had those problems anyway.

The patch, wich upgrades to version LK1.1.16, works perfectly, I have not
seen this patch on 2.4.8pre4 and I think that it would be good to apply it
before 2.4.8, as the driver on 2.4.7 doesn't work at all at least with this
card.

Regards...
-- 
Manty/BestiaTester -> http://manty.net

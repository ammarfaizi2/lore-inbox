Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbSLKSwF>; Wed, 11 Dec 2002 13:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267277AbSLKSwE>; Wed, 11 Dec 2002 13:52:04 -0500
Received: from flora.INS.CWRU.Edu ([129.22.8.235]:58564 "EHLO
	flora.INS.cwru.edu") by vger.kernel.org with ESMTP
	id <S267273AbSLKSwE>; Wed, 11 Dec 2002 13:52:04 -0500
Date: Wed, 11 Dec 2002 14:01:32 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
To: linux-kernel@vger.kernel.org
Subject: Destroying processes
Message-ID: <20021211190132.GF147@lothlorien.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey 00ber-geeks,

I'm not subscribed (yet....still too lazy to subscribe ;P ), but I have a
question and/or suggestion.

Is there a system call that would destroy a process?  Sometimes I end up with
zombie processes, other times I end up with a process attaching to a device
driver, and hanging, so I want to be able to completely destroy the
process...image, file handle, driver hooks, everything.  If there isn't one,
and noone wants to do it, I'll gladly do it (may take a few weeks tho).  I just
don't wanna do what someone else has already done.

Thanks,

Justin Hibbits

-- 
Registered Linux user 260206

"One World, One Web, One Program"
	- Microsoft Promo Ad
"Ein Volk, Ein Reich, Ein Fuhrer"
	- Adolf Hitler

I'm not paranoid.  They really *are* out to get me!


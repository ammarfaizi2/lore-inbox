Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267081AbSKWVEW>; Sat, 23 Nov 2002 16:04:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbSKWVEW>; Sat, 23 Nov 2002 16:04:22 -0500
Received: from assisi.INS.CWRU.Edu ([129.22.8.14]:27602 "EHLO
	assisi.INS.cwru.edu") by vger.kernel.org with ESMTP
	id <S267081AbSKWVEV>; Sat, 23 Nov 2002 16:04:21 -0500
Date: Sat, 23 Nov 2002 16:12:47 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
To: linux-kernel@vger.kernel.org
Subject: ps2 mouse remapping keyboard
Message-ID: <20021123211247.GB413@lothlorien.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I'm not subscribed right now, but I have a major problem.  For some reason,
sometimes when I startup either gpm or X, my keyboard gets remapped, so that
several of the keys return keycode 0x70 or 0x71, while others return 0x56, and
the rest return extended e0/e1 keycodes.  I'm unsure why this happens.  It
started happening when I installed dri drivers off dri.sf.net, but even after
removing those drivers, deleting the kernel source tree, and starting from
scratch, it still happens.  I'm at a loss, so if someone can shed some light on
this, I'd be grateful.
this happens sporadically, so not exactly sure what the problem is.  Hopefully
this won't happen when I get a USB mouse/keyboard for christmas :) /me crosses
fingers.

Thanks in advance,

Justin Hibbits


-- 
Registered Linux user 260206

"One World, One Web, One Program"
	- Microsoft Promo Ad
"Ein Volk, Ein Reich, Ein Fuhrer"
	- Adolf Hitler

I'm not paranoid.  They really *are* out to get me!


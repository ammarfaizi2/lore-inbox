Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132235AbQKSDvJ>; Sat, 18 Nov 2000 22:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132236AbQKSDu7>; Sat, 18 Nov 2000 22:50:59 -0500
Received: from nessie.weebeastie.net ([61.8.7.205]:14599 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id <S132235AbQKSDut>; Sat, 18 Nov 2000 22:50:49 -0500
Date: Sun, 19 Nov 2000 14:20:39 +1100
From: CaT <cat@zip.com.au>
To: linux-kernel@vger.kernel.org
Subject: 2.4.0test11pre7 and synaptics touchpad
Message-ID: <20001119142039.A612@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an attempt to see how 2.4.0 would go with my notebook I grabbed
the latest and compiled it. It booted fine but my touchpad wouldn't
work properly. It was highly unresponsive... as if it was missing
movements alot. It'd move at one time and at another it would not.
It was very unusable.

I had input core support compiled in and non-serial/bus mouse support
aswell. Was there anything else I should've compiled in? Did I miss
something?

I was using gpm 1.19.3 with it with synps2 mouse driver. I just looked
in the logfiles and couldn't see anything that screamed out at me. 
Anything specific I should look for? I'm currently back in 2.2.18pre21
where the touchpad works really well.

-- 
CaT (cat@zip.com.au)

	'We do more then just sing and dance. We've got a brain too.'
		-- The Backstreet Boys
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

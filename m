Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261200AbULHNES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261200AbULHNES (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 08:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbULHNES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 08:04:18 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:50447 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261200AbULHNEO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 08:04:14 -0500
Date: Wed, 8 Dec 2004 14:04:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/alpha/Kconfig: duplicated entries (fwd)
Message-ID: <20041208130408.GU5496@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I didn't get any answers regarding the email below.

Could someone please answer?

TIA
Adrian


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sat, 13 Nov 2004 00:52:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/alpha/Kconfig: duplicated entries

Current 2.6 kernels contain more than one entry for the follwing symbols 
in arch/alpha/Kconfig :
- ALPHA_EV4
- ALPHA_EV56
- ALPHA_GAMMA

If someone tells me the intended semantics of these options, I can send 
a patch.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----


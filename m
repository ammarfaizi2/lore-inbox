Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262717AbUKLX61@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262717AbUKLX61 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262712AbUKLX5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:57:20 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:64011 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262722AbUKLXxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:53:14 -0500
Date: Sat, 13 Nov 2004 00:52:40 +0100
From: Adrian Bunk <bunk@stusta.de>
To: rth@twiddle.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] arch/alpha/Kconfig: duplicated entries
Message-ID: <20041112235240.GN2249@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267425AbUG2VaJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267425AbUG2VaJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 17:30:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUG2V2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 17:28:53 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:21476 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S267425AbUG2V1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 17:27:45 -0400
Date: Thu, 29 Jul 2004 23:27:37 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, linux-dvb-maintainer@linuxtv.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.8-rc2-mm1: DVB: "errno" undefined
Message-ID: <20040729212737.GH23589@fs.tum.de>
References: <20040728020444.4dca7e23.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040728020444.4dca7e23.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting the following errors when trying to compile 2.6.8-rc2-mm1 as 
modular as possible (using gcc 2.95):

<--  snip  -->

...
*** Warning: "errno" [drivers/media/dvb/frontends/tda1004x.ko] undefined!
*** Warning: "errno" [drivers/media/dvb/frontends/sp887x.ko] undefined!
*** Warning: "errno" [drivers/media/dvb/frontends/alps_tdlb7.ko] undefined!
...

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed


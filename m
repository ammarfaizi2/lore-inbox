Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267318AbUGNIfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267318AbUGNIfg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 04:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267323AbUGNIfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 04:35:36 -0400
Received: from ethlife-a.ethz.ch ([129.132.202.7]:31888 "HELO ethlife.ethz.ch")
	by vger.kernel.org with SMTP id S267318AbUGNIff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 04:35:35 -0400
Mime-Version: 1.0
Message-Id: <p04320400bd1a91c54a80@[192.168.40.11]>
Date: Wed, 14 Jul 2004 10:35:29 +0200
To: linux-kernel@vger.kernel.org
From: Christian Jaeger <christian.jaeger@ethlife.ethz.ch>
Subject: (2.6.8-rc1 crash on ppc (powerbook g3))
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello

kernel.org's 2.6.8-rc1 crashed upon wakeup of my lombard
and after reboot, later on, while booting MacOs under mol (which 
worked before), it even just did a poweroff.

(It's strange: somehow this laptop seems to trigger poweroffs with 
many kernels. it's definitely software related, as some kernels are 
completely reliable, but if the kernels are not reliable, the problem 
no. 1 is poweroffs. Or maybe no. 2 - the other most frequent problem 
are freezes (as usual).)

sorry for not having more info, i'm lacking time and have just booted 
back into 2.6.5 for now. (i'd be glad not to run a kernel with local 
holes, though..)

christian.

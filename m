Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135883AbRDYPoX>; Wed, 25 Apr 2001 11:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135886AbRDYPoO>; Wed, 25 Apr 2001 11:44:14 -0400
Received: from nakyup.mizi.com ([203.239.30.70]:19328 "EHLO nakyup.mizi.com")
	by vger.kernel.org with ESMTP id <S135883AbRDYPoD>;
	Wed, 25 Apr 2001 11:44:03 -0400
Date: Thu, 26 Apr 2001 00:44:00 +0900
From: "Young-Ho. Cha" <ganadist@nakyup.mizi.com>
To: linux-kernel@vger.kernel.org
Subject: SMP and USB keyboard
Message-ID: <20010426004400.A3008@nakyup.mizi.com>
Reply-To: ganadist@chollian.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. kernel hackers.

I use kernel 2.4.3-ac4 with smp support                                         

and I have found strange problem in using usb keyboard.

When I pressed CAPS, NUM, SCROLL LOCK key twice (toggle LED light on keyboard), 

Keyboard and console goes hang.

but up(uni-processor) kernel has no problem.

I use

gcc 2.95.3
glibc 2.2.2
make 3.79.1
binutils 2.10.1
util-linux 2.10q
modutils 2.4.2 

and used usb-uhci and keybdev modules.

anybody have been heard same problems?

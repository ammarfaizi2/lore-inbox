Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283489AbRK3DJU>; Thu, 29 Nov 2001 22:09:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283490AbRK3DJK>; Thu, 29 Nov 2001 22:09:10 -0500
Received: from TK212017087078.teleweb.at ([212.17.87.78]:28925 "EHLO
	elch.elche") by vger.kernel.org with ESMTP id <S283489AbRK3DI4>;
	Thu, 29 Nov 2001 22:08:56 -0500
Date: Fri, 30 Nov 2001 04:07:19 +0100
From: Armin Obersteiner <armin@xos.net>
To: linux-kernel@vger.kernel.org
Subject: usb slow in >2.4.10
Message-ID: <20011130040719.A21515@elch.elche>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

all my usb devices work, but they are very slow (12 times slower) with kernels
2.4.14 and higher. it definetly was ok with 2.4.10.

tested with rio500 and my digital camera. it seems fast enough for the graphics
tablet.

i've seen this reported before, but no answers given. the problem persists for over
a month now, and i tried nearly every new kernel/pre-kernel.

there is no usb error in "messages", everything looks fine.

MfG,
	Armin Obersteiner
--
armin@xos.net                        pgp public key on request        CU

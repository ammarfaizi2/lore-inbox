Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbWG3RiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbWG3RiT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 13:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbWG3RiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 13:38:18 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29161 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932389AbWG3RiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 13:38:05 -0400
Subject: Re: [PATCH 00/23] V4L/DVB fixes
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mauro Carvalho Chehab <mchehab@infradead.org>,
       linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       akpm@osdl.org, Linux and Kernel Video <video4linux-list@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
References: <20060725180311.PS54604900000@infradead.org>
	 <1154222716.27019.39.camel@praia>
	 <Pine.LNX.4.64.0607292300070.4168@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 30 Jul 2006 18:56:40 +0100
Message-Id: <1154282200.1615.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-07-29 am 23:02 -0700, ysgrifennodd Linus Torvalds:
> which is almost an order of magnitude less.
> 
> It's much too late to do this kind of big changes now.

Can we get the small ones in at least , like the fact bttv actually last
worked properly about 2.6.16 because someone mistakenly (despite being
warned) changed the VBI capture values to match the spec not the chip.

Alan


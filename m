Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129604AbRAMIIY>; Sat, 13 Jan 2001 03:08:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131669AbRAMIIO>; Sat, 13 Jan 2001 03:08:14 -0500
Received: from iliganet-ipgi.iligan.com ([216.226.192.4]:58386 "HELO
	iliganet-ipgi.iligan.com") by vger.kernel.org with SMTP
	id <S129604AbRAMIH6>; Sat, 13 Jan 2001 03:07:58 -0500
Date: Sat, 13 Jan 2001 16:09:34 +0800 (PHT)
From: rtviado <root@iligan.com>
To: <linux-kernel@vger.kernel.org>
Subject: lots of reset_xmit_timer message log
In-Reply-To: <Pine.LNX.4.21.0101122224520.1079-100000@home.lameter.com>
Message-ID: <Pine.LNX.4.30.0101131601020.8137-100000@bigbird-ipgi.iligan.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello kernel gurus,

updating to 2.4.0 final i get a lot of this in my logs

reset_xmit_timer sk=c07929a0 1 when=0x3c61, caller=c01b68c5
reset_xmit_timer sk=c85d8360 1 when=0x3c87, caller=c01b68c5
reset_xmit_timer sk=c29309a0 1 when=0x3ce7, caller=c01b68c5
sending pkt_too_big to self

I think this is related to ne2k-pci driver.....



-- 
Rodel


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

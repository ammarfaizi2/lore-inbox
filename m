Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130346AbRAIXdr>; Tue, 9 Jan 2001 18:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131022AbRAIXdk>; Tue, 9 Jan 2001 18:33:40 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:8301 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S130346AbRAIXd0>; Tue, 9 Jan 2001 18:33:26 -0500
Date: Tue, 9 Jan 2001 23:35:08 +0000
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: USB problems with 2.4.0
Message-ID: <20010109233508.A832@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


System is a KA7-100, sole USB peripheral is a Logitech MouseMan Wheel.

If I use the uhci driver, it doesn't initialise properly (there is a
message along the lines of "something bad happened".  If I use the
usb-uhci driver, I frequently get an oops if I move the mouse during
bootup.

If anyone is interested I will try to obtain a decoded oops report.

I've had this problem for a while and have reported it here before, as
well as to one of the USB maintainers, but with no result so far.


Adam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

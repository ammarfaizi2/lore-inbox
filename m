Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280326AbRJaRXn>; Wed, 31 Oct 2001 12:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280329AbRJaRX0>; Wed, 31 Oct 2001 12:23:26 -0500
Received: from shimura.Math.Berkeley.EDU ([169.229.58.53]:47232 "EHLO
	shimura.math.berkeley.edu") by vger.kernel.org with ESMTP
	id <S280321AbRJaRXL>; Wed, 31 Oct 2001 12:23:11 -0500
Date: Wed, 31 Oct 2001 09:23:42 -0800 (PST)
From: Wayne Whitney <whitney@math.berkeley.edu>
Reply-To: <whitney@math.berkeley.edu>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Status of IDE Hot Swap?
Message-ID: <Pine.LNX.4.33.0110310902540.23449-100000@mf1.private>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

What is the current status of IDE Hot Swap, in terms of any necessary
kernel support?  As far as I can see, this was last discussed here in
March, when Andre Hedrick indicated he had some preliminary, unreleased
code to do this.

The hardware I am thinking of would be a run-of-the-mill ATA/100
controller, a run-of-the-mill ATA/100 drive, and a hot swap bay such as
the Promise SuperSwap (http://www.promise.com/PDF/sswapds.pdf) or the
RyAim KF-21-IPF (http://www.ryaim.com/products/accessory/kf21.htm).  One
possible application would be using an IDE drive as a removable backup
device (allowing off-site storage).

Cheers, Wayne



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbTDPHY7 (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 03:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264253AbTDPHY7 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 03:24:59 -0400
Received: from amalthea.dnx.de ([193.108.181.146]:14560 "HELO amalthea.dnx.de")
	by vger.kernel.org with SMTP id S264252AbTDPHY6 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 03:24:58 -0400
Date: Wed, 16 Apr 2003 09:36:35 +0200
From: Robert Schwebel <robert@schwebel.de>
To: David Brownell <david-b@pacbell.net>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>, Linus Torvalds <torvalds@transmeta.com>,
       linux-kernel@vger.kernel.org
Subject: Chosing the right Linux "USB Gadget" API and Driver Framework
Message-ID: <20030416073635.GA10886@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Spam-Score: -1.2 (/)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *195hT9-0001DB-00*cDa1wprUHyY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm currently working on support for the USB gadget controller inside
the Intel PXA25x XScale processor. David Brownell has recently published
a new USB gadget API which was discussed on linux-usb-devel and which
seems to be a good starting point.

As there is at least one other API (by Belcarra, former Lineo code) I'm
wondering what Greg's and Linus' position concerning the new USB gadget
API is. A comment from your side would be welcome. 

Cheers,
Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry


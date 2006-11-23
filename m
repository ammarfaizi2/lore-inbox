Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756355AbWKWSJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355AbWKWSJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757361AbWKWSJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 13:09:13 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:33672 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1756355AbWKWSJN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 13:09:13 -0500
Date: Thu, 23 Nov 2006 19:08:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: DervishD <lkml@dervishd.net>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage data errors
In-Reply-To: <20061122105322.GA17351@DervishD>
Message-ID: <Pine.LNX.4.61.0611231908090.8427@yvahk01.tjqt.qr>
References: <20061122105322.GA17351@DervishD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 22 2006 11:53, DervishD wrote:
>    - Two different usb-storage adapters (an external USB box from an
>      unknown manufacturer and Conceptronic CIDE23U). Both are
>      USB-to-IDE adapters.
>
>    In addition to this, from time to time the usb-storage adapters
>(any of them, with any of the USB cards and any kernel) report a read
>error, telling that some sector could not be read. This is false
>because if I repeat the operation, the sector is correctly retrieved.
>This can be related to some kind of timing problem, I don't know.

Try with some real USB storage device instead of a USB-to-IDE converter.


	-`J'
-- 

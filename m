Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTAEUic>; Sun, 5 Jan 2003 15:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTAEUic>; Sun, 5 Jan 2003 15:38:32 -0500
Received: from grobbebol.xs4all.nl ([194.109.248.218]:9293 "EHLO
	grobbebol.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265250AbTAEUi2>; Sun, 5 Jan 2003 15:38:28 -0500
Date: Sun, 5 Jan 2003 21:47:02 +0100
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: usb_control/bulk_msg: timeout 2.4.20 stock kernel
Message-ID: <20030105204702.GA24622@grobbebol.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi all,



maybe it's just me or something but.. I have since 2.4.20 the following
problem with a fujifilm finepix 1300 camera.

when I switch on the camera :

[....]
Jan  5 21:38:25 grobbebol last message repeated 76 times
Jan  5 21:39:24 grobbebol kernel: usb_control/bulk_msg: timeout
Jan  5 21:39:24 grobbebol kernel: usb.c: USB device not accepting new
address=9 (error=-110)
Jan  5 21:39:28 grobbebol kernel: usb_control/bulk_msg: timeout
Jan  5 21:39:28 grobbebol kernel: usb.c: USB device not accepting new
address=10 (error=-110)
[....]

etc is shown. I am 100% sure 2.4.18 didn't do this. there also is a usb
cam present that works just fine.

anyone who has a tip or maybe a place where to look ? I googled around
but no obvious links.




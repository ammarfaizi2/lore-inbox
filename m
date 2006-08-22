Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932147AbWHVRfg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWHVRfg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 13:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHVRfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 13:35:36 -0400
Received: from mailer.gwdg.de ([134.76.10.26]:55175 "EHLO mailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751390AbWHVRfg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 13:35:36 -0400
Date: Tue, 22 Aug 2006 19:34:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Peter Korsgaard <jacmet@sunsite.dk>
cc: linux-kernel@vger.kernel.org, device@lanana.org
Subject: Re: [PATCH] Update Documentation/devices.txt
In-Reply-To: <87d5aserky.fsf@slug.be.48ers.dk>
Message-ID: <Pine.LNX.4.61.0608221934120.14463@yvahk01.tjqt.qr>
References: <87d5aserky.fsf@slug.be.48ers.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>@@ -2565,10 +2565,10 @@ Your cooperation is appreciated.
> 		243 = /dev/usb/dabusb3	Fourth dabusb device
> 
> 180 block	USB block devices
>-		  0 = /dev/uba		First USB block device
>-		  8 = /dev/ubb		Second USB block device
>-		 16 = /dev/ubc		Third USB block device
>-		    ...
>+		0 = /dev/uba		First USB block device
>+		8 = /dev/ubb		Second USB block device
>+		16 = /dev/ubc		Third USB block device
>+ 		    ...

What's the reason for this indent change?


Jan Engelhardt
-- 

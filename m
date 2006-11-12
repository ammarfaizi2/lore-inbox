Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753242AbWKLVj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753242AbWKLVj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 16:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753250AbWKLVj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 16:39:58 -0500
Received: from emailer.gwdg.de ([134.76.10.24]:65475 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1753244AbWKLVj5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 16:39:57 -0500
Date: Sun, 12 Nov 2006 22:38:09 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Oliver Neukum <oliver@neukum.org>
cc: Ivo van Doorn <ivdoorn@gmail.com>, Dmitry Torokhov <dtor@insightbb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] RFkill - Add support for input key to control wireless
 radio
In-Reply-To: <200611121613.46286.oliver@neukum.org>
Message-ID: <Pine.LNX.4.61.0611122237550.4951@yvahk01.tjqt.qr>
References: <200611121548.56908.IvDoorn@gmail.com> <200611121613.46286.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> If the input device has been opened, rfkill will send the signal to
>> userspace and do nothing further. The user is in charge of controlling
>> the radio.
>
>As turning off the radio is relevant to safety eg. in aircraft, hospitals,
>etc., potentially ignoring the button is questionable.

"Policy does not belong into the kernel".


	-`J'
-- 

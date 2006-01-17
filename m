Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWAQQZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWAQQZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 11:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932142AbWAQQZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 11:25:42 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:45035 "EHLO
	vms042pub.verizon.net") by vger.kernel.org with ESMTP
	id S932141AbWAQQZm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 11:25:42 -0500
Date: Tue, 17 Jan 2006 11:25:40 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: Linux 2.6.16-rc1
In-reply-to: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200601171125.40854.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 January 2006 03:19, Linus Torvalds wrote:
>Ok, it's two weeks since 2.6.15, and the merge window is closed.

Well, I sorta broke my never build an -rc1 rule.

It seems to be stable so far, but I have a cx88 based video card, a 
pcHDTV-3000, and there's 2 problems with the audio.  That dma function 
was turned off in the .config as the lspci -n didn't report the right 
numbers.

1. tvtimes volume control has no effect, in kamix, its now the 'front' 
slider.  Its actually plugged into the line in jack of a SBLive Audigy 
2 Value card.

2. The audio has a definite 'dragging voice coil' sound, very tiresome 
to listen to, highly clipped regardless of the gain settings.

Since I do watch tv on this box, I'll go back to 2.6.15.1 until -rc2 is 
released.

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.

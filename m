Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263113AbTHVMbk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 08:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263112AbTHVMbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 08:31:40 -0400
Received: from 205-158-62-67.outblaze.com ([205.158.62.67]:34459 "EHLO
	spf13.us4.outblaze.com") by vger.kernel.org with ESMTP
	id S263113AbTHVLHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 07:07:44 -0400
Message-ID: <20030822110830.15262.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Luis Medinas" <metalgodin@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Fri, 22 Aug 2003 19:08:30 +0800
Subject: Re: Problem with 2.6-testXX and alcatel speedtouch usb modem
X-Originating-Ip: 194.65.14.75
X-Originating-Server: ws5-8.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I try to make this modem working.
>It works very well on kernel 2.4 series.
>It work with some kernel 2.6 until test2-mm1.
>But since test2-mm1, the newer kernel doesn't work anymore.
>There is 2 related drivers for this modem.
>The one which is included in the kernel and which can be found here :
>http://www.linux-usb.org/SpeedTouch/
>and the one which I've always used until now :
>speedtouch.sourceforge.net

>when I notice that the old one doesn't work anymore, I try with the driver 
>which included in the kernel, without success.

>It crashed when I do "pppd call adsl".
>I can load the firmware.

Looks like this is happening to all 2.6.0-test3 users with speedtouch usb modems
And i heard that speedtouch.sf.net developers want to leave 2.6 tree stabilize more a little bit to continue develop drivers with the correct support.

Im sure we can help test drivers with the correct support for 2.6 
-- 
______________________________________________
http://www.linuxmail.org/
Now with e-mail forwarding for only US$5.95/yr

Powered by Outblaze

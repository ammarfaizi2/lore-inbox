Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270027AbTGSLR4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 07:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270046AbTGSLRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 07:17:55 -0400
Received: from smtp.netcabo.pt ([212.113.174.9]:35132 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S270027AbTGSLRw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 07:17:52 -0400
Message-ID: <3F198D06.4090601@netcabo.pt>
Date: Sat, 19 Jul 2003 19:25:10 +0100
From: Pedro Ribeiro <deadheart@netcabo.pt>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: All kernel versions && USB Speakers
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Jul 2003 11:27:49.0370 (UTC) FILETIME=[C8D59DA0:01C34DE8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been using a Microsoft Sound System 80 for some long now and I've 
allways noticed a strange message in boot. The only thing I need to get 
this thing running is UHCI and USB sound support. Here's the message:

Jul 19 19:04:29 deadheart kernel: usbaudio: device 2 interface 1 
altsetting 0 does not have an endpoint
Jul 19 19:04:29 deadheart kernel: usbaudio: device 2 interface 1 
altsetting 5 unsupported channels 1 framesize 3
Jul 19 19:04:29 deadheart kernel: usbaudio: device 2 interface 1 
altsetting 6 unsupported channels 2 framesize 3
Jul 19 19:04:29 deadheart kernel: usbaudio: warning: found 2 of 1 
logical channels.
Jul 19 19:04:29 deadheart kernel: usbaudio: no idea what's going on..., 
contact linux-usb-devel@lists.sourceforge.net
Jul 19 19:04:29 deadheart kernel: usbaudio: mixer request device 2 if 0 
unit 11 ch 1 selector 2 failed

I don't have any problem at all with it.. just checking.

PR


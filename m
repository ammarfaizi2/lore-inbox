Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTJZQYt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 11:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263276AbTJZQYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 11:24:49 -0500
Received: from law10-f30.law10.hotmail.com ([64.4.15.30]:61200 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S263274AbTJZQYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 11:24:47 -0500
X-Originating-IP: [4.4.2.132]
X-Originating-Email: [boomerang_56@hotmail.com]
From: "Keith Clark" <boomerang_56@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6 test 8 locks up when encoding Divx/Xvid
Date: Sun, 26 Oct 2003 16:24:43 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F30wcdZ06YO4O0000aabd@hotmail.com>
X-OriginalArrivalTime: 26 Oct 2003 16:24:43.0587 (UTC) FILETIME=[A9D4A930:01C39BDD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I use DVD::Rip / Transcode to encode a VOB file to an Xvid format AVI, 
then the whole machine locks up and the only recourse is to hit the reset 
button : it won't repond to pings, open telnet sessions become unresponsive, 
etc.  I've also experienced lockups when using Kino to export in Divx 
format.

If I boot to the old 2.4.20 (latest RedHat kernel), then I can encode files 
for days with no lockups.

I don't monitor the mailing list, I found this address at kernel.org. If you 
need more info, send me an email and I'll forward any appropriate logs, but 
have no idea at this point which ones would be applicable. I haven't seen 
anything in /var/log/messages that gave me any clues.

I really like 2.6test 8 otherwise. I have Win2K on this machine as well, and 
for the first time, everything in Linux - from a desktop user perspective, 
runing Gnome 2.4 - is faster than in Win2K.

Nice work.

_________________________________________________________________
Enjoy MSN 8 patented spam control and more with MSN 8 Dial-up Internet 
Service.  Try it FREE for one month!   http://join.msn.com/?page=dept/dialup


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265179AbUAPOvu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 09:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265156AbUAPOvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 09:51:50 -0500
Received: from mta14.srv.hcvlny.cv.net ([167.206.5.83]:36260 "EHLO
	mta14.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S265179AbUAPOvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 09:51:10 -0500
Date: Fri, 16 Jan 2004 09:51:14 -0500
From: Brett Gmoser <aftli@optonline.net>
Subject: Re: Raw I/O Problems with inb()
In-reply-to: <pan.2004.01.16.11.27.43.359172@smurf.noris.de>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <6.0.1.1.0.20040116094624.00acea40@optonline.net>
MIME-version: 1.0
X-Mailer: QUALCOMM Windows Eudora Version 6.0.1.1
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
References: <20040115215243.39fcb0fd.aftli@optonline.net>
 <pan.2004.01.16.11.27.43.359172@smurf.noris.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Reading port registers directly doesn't make sense. No USB keyboards, no
>remote use, ... you need to drop your DOS programming mentaility. Fast.

Thanks for your input.  However, I do not want the application to work 
remotely.  I have examined all other options, and this is the best way to 
do it under the circumstances which I need this program to work.

The question is not one of "how" to accomplish all of this, it is how to 
get inb(0x64) to state that it is indeed mouse movement, and not keyboard 
data, on an AMD Athlon XP system with PS/2 mouse.

Thanks again!

Brett



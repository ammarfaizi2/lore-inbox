Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262236AbTIZOO7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 10:14:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbTIZOO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 10:14:59 -0400
Received: from wotug.org ([194.106.52.201]:31294 "EHLO ivimey.org")
	by vger.kernel.org with ESMTP id S262236AbTIZOO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 10:14:57 -0400
Date: Fri, 26 Sep 2003 15:14:57 +0100 (BST)
From: Ruth Ivimey-Cook <Ruth.Ivimey-Cook@ivimey.org>
X-X-Sender: ruthc@gatemaster.ivimey.org
To: linux-kernel@vger.kernel.org
Subject: More on IDE controller choice
Message-ID: <Pine.LNX.4.44.0309261507140.22241-100000@gatemaster.ivimey.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.3 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

Further to my request for info on the Promise controllers, I have just 
discovered that the GA-7N400 Pro2 motherboard would suit, if there were decent 
Linux support for the ethernet controller (RealTek 8169 GBit -- I think this 
is ok, yes?) and the IDE controller - a GigaRAID device, aka ITE 8212. There 
seems to be conflicting reports about this. There is a binary Linux driver 
available from GigaByte, but no source. Some have reported that source is 
available from ITE, but I can't find where. Some reports say the driver is in 
the kernel dist, but I can only see the driver for a different ITE chip and no 
indication it does more than one.

Can anyone help?

I am getting v.close to go for the devil I know -- the Promise chips -- rather
than the possible angel I don't. I don't wish to pay enough for the 3ware
controller, even if I could find a UK supplier (I havent, yet), and even some
reports of the Adaptec 1200A are rather downbeat. I would probably end up with
the HighPoint controller in the RocketRAID 404 if pushed too far by failing
Promise's.

Regards,

Ruth

-- 
Ruth Ivimey-Cook
Software engineer and technical writer.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUGOKjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUGOKjz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 06:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265542AbUGOKjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 06:39:55 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:61152 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S265230AbUGOKjy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 06:39:54 -0400
Message-ID: <40F66021.6000804@tiscali.it>
Date: Thu, 15 Jul 2004 12:44:49 +0200
From: pietro canevarolo <pietro.canevarolo@tiscali.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a2) Gecko/20040703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cannot ping from a usb-serial device 
References: <20040714000810.GA7308@fs.tum.de> <20040714090159.GA3821@pclin040.win.tue.nl> <20040715025948.GA19092@fs.tum.de>
In-Reply-To: <20040715025948.GA19092@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I am developing a portable device that I must connect to Internet via usb.
I connect to my linux box with pppd on ttyUSB0 and the link layer is 
working ok. I can ping my device from all the machines connected, but 
when the device pings some address known reacheable my linux box sees 
the packets ("ifconfig ppp0" returns the correct number of packets 
exchanged and "netstat -i" reports the correct number of bytes on the 
interface), but no echo replies come back to my device.
I understand that my question may be silly for this forum, but I am 
really out of resources.
Can someone out there point me to some info to understand why this is 
happening?

many tnx

pietro canevarolo

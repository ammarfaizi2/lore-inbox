Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312107AbSCQUGn>; Sun, 17 Mar 2002 15:06:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312106AbSCQUGe>; Sun, 17 Mar 2002 15:06:34 -0500
Received: from front1.mail.megapathdsl.net ([66.80.60.31]:36619 "EHLO
	front1.mail.megapathdsl.net") by vger.kernel.org with ESMTP
	id <S312104AbSCQUGV>; Sun, 17 Mar 2002 15:06:21 -0500
Message-ID: <3C94F6FB.8090207@megapathdsl.net>
Date: Sun, 17 Mar 2002 12:05:15 -0800
From: Miles Lane <miles@megapathdsl.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.7-pre2 -- Error seeking in /dev/kmem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anyone else seeing this?  I have been getting these errors
throughout much of the 2.5 development cycle.  I am not sure
when the problem started, since I have had a lot of trouble
getting most of the 2.5 series kernels to build.

Mar 17 11:15:02 turbulence kernel: Loaded 22474 symbols from 
/boot/System.map-2.5.7-pre2.
Mar 17 11:15:02 turbulence kernel: Symbols match kernel version 2.5.7.
Mar 17 11:15:02 turbulence kernel: Error seeking in /dev/kmem
Mar 17 11:15:02 turbulence kernel: Symbol #af_packet, value d98dd000
Mar 17 11:15:02 turbulence kernel: Error adding kernel module table entry.


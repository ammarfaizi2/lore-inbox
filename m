Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317793AbSHaRWv>; Sat, 31 Aug 2002 13:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317782AbSHaRWv>; Sat, 31 Aug 2002 13:22:51 -0400
Received: from imo-d09.mx.aol.com ([205.188.157.41]:23712 "EHLO
	imo-d09.mx.aol.com") by vger.kernel.org with ESMTP
	id <S317778AbSHaRWu>; Sat, 31 Aug 2002 13:22:50 -0400
Message-ID: <3D70FC6E.7060907@netscape.net>
Date: Sat, 31 Aug 2002 14:27:10 -0300
From: jgluckca@netscape.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020513 Netscape/7.0b1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 trashes CMOS
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I'm really not sure who to send this to since I have no idea when or 
where it happens.

The problem does not happen on version 2.4.18 or any earlier version. I 
checkout the hardware after constantly getting CMOS checksum errors on 
bootup. There is no hardware problem.

My configurations of 2.4.18 and 2.4.19 are identical. They are SMP 
kernels for a dual PIII on a Tyan S1836DLUAN motherboard. I used gcc3.1 
to compile both kernels.
If I boot 2.4.19 and then ask it to reboot (no power off). I do 
"shutdown -r now" the CMOS will be trashed. I've gone back to the 2.4.18 
kernel and the problem is gone.

I'll be happy to look at the problem in detail if someone can tell me 
where to start looking. I'm a professional programmer with experience in 
writing operating systems. I haven't looked at the Linux kernel in any 
detail though.

Please reply to me directly since I don't subscribe to this list.

Thanks

John


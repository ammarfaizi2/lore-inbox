Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267518AbRGUBvp>; Fri, 20 Jul 2001 21:51:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbRGUBvf>; Fri, 20 Jul 2001 21:51:35 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:45732 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S267518AbRGUBvc>; Fri, 20 Jul 2001 21:51:32 -0400
Message-ID: <3B58D19A.9080509@earthlink.net>
Date: Fri, 20 Jul 2001 20:49:30 -0400
From: Brad Chapman <kakadu@earthlink.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i586; en-US; C-UPD: MaxLinux0301) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Strange behavior with 2.4.x on a Celeron
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Hello,

   I have a Celeron 400MHz/66MHz with 256MB of RAM, a 6.4GB Quantum Fireball
and an onboard SiS AGP chipset. I am currently running 2.4.5. I have 
noticed
that when I unpack large tar files on my system, it will sometimes lock up
the hard disk, and I would also guess the filesystem code with it. When 
I try
to switch to another VC to kill the tar process, it hangs when I run ps ax.
When I try to run ANY command which accesses the hard disk, it also hangs.
Accessing /proc or /dev (I use devfs) doesn't cause any problems. Anyone 
have
any ideas?

Thanks,

Brad


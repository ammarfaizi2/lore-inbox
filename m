Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261729AbSJZAUO>; Fri, 25 Oct 2002 20:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSJZAUN>; Fri, 25 Oct 2002 20:20:13 -0400
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:53764 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261729AbSJZAUM>; Fri, 25 Oct 2002 20:20:12 -0400
Date: Fri, 25 Oct 2002 14:36:28 -0500
From: Courtney Grimland <cgrimland@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: unsupported agp
Message-Id: <20021025143628.7736b8df.cgrimland@yahoo.com>
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Real Men Don't Use Distros - www.linuxfromscratch.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stock linux 2.4.19
Gigabyte 7VAXP motherboard
 - VIA KT400 PAC
 - VIA VT8235 PSIPC


I tried append="... agp_try_unsupported=1" in lilo.conf, but I still get 
the same error message.  What can I do?



relevant dmesg output:

Linux agpgart interface v0.99 (c) Jeff Hartmann
agpgart: Maximum main memory to use for agp memory: 203M
agpgart: Unsupported Via chipset (device id: 3189), you might want to try agp_try_unsupported=1.
agpgart: no supported devices found.
[drm] Initialized radeon 1.1.1 20010405 on minor 0

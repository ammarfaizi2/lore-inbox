Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135705AbRDVIsx>; Sun, 22 Apr 2001 04:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135798AbRDVIso>; Sun, 22 Apr 2001 04:48:44 -0400
Received: from [212.150.138.2] ([212.150.138.2]:49157 "EHLO
	ntserver.voltaire.com") by vger.kernel.org with ESMTP
	id <S135705AbRDVIsc> convert rfc822-to-8bit; Sun, 22 Apr 2001 04:48:32 -0400
Message-ID: <20083A3BAEF9D211BDB600805F8B14F3D857E1@NTSERVER>
From: Miri Groentman <mirig@voltaire.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: ip forwarding ans kernel networking questions
Date: Sun, 22 Apr 2001 11:47:05 +0200
X-Message-Flag: Follow up
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="windows-1255"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I’m a newbie to Linux kernel, and I’m trying to understand some networking
issues in kernel 2.4. 
I will highly appreciate it if anyone could refer me to kernel networking
documentation in general, and tcp / ip stack documentation in particular.
I’ve been reading tcp/ip illustrated (vol. II), but it seems like in these
issues the 2.4 kernel version is quite different from BSD.
I’m especially looking for answers to questions such as where in the code a
host validates the packet ip? 
Where in the code the a packet which is addressed to a different ip is
dropped / discarded  (when the kernel isn’t configured as a router), and
where in the code a packet is forwarded when the kernel IS configured as a
router?
Thanks
-Miri

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279749AbRKSPeY>; Mon, 19 Nov 2001 10:34:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279472AbRKSPeG>; Mon, 19 Nov 2001 10:34:06 -0500
Received: from NET.WAU.NL ([137.224.10.12]:20997 "EHLO net.wau.nl")
	by vger.kernel.org with ESMTP id <S278940AbRKSPdp>;
	Mon, 19 Nov 2001 10:33:45 -0500
Date: Mon, 19 Nov 2001 16:33:44 +0100
From: Olivier Sessink <lists@olivier.pk.wau.nl>
Subject: mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary
To: linux-kernel@vger.kernel.org
Message-id: <20011119163344.039f5309.lists@olivier.pk.wau.nl>
Organization: Wageningen Multimedia Software Labs
MIME-version: 1.0
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I got this message when I restarted X on a Sony Vaio R600HEK notebook
(Intel 815 chipset)

mtrr: base(0xf8000000) is not aligned on a size(0x180000) boundary

X was non-responsive, but another X restart solved the problem.

More info about this laptop can be found here
http://lx.student.wau.nl/~olivier/linux_on_r600hek/linux_on_r600hek.html

is this something critical?

regards,
	Olivier

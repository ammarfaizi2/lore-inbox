Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbSLBBBN>; Sun, 1 Dec 2002 20:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262959AbSLBBBN>; Sun, 1 Dec 2002 20:01:13 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:51693 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S262937AbSLBBBN>;
	Sun, 1 Dec 2002 20:01:13 -0500
Date: Mon, 2 Dec 2002 12:08:35 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Maximum Physical Memory on 2.4 and ia32
Message-Id: <20021202120835.4ecb87fd.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This may be a FAQ (but I did search).

Given this statement by RedHat:

"RAM Limitations on IA32

Red Hat Linux releases based on the 2.4 kernel -- including Red Hat Linux
7.1, 7.2, 7.3 and Red Hat Linux Advanced Server 2.1 -- support a maximum
of 16GB of RAM. Previous product announcements from Red Hat suggested that
Red Hat Linux 7.1 (and by extension, other releases based on the 2.4
kernel) supported up to 64GB of RAM. A more accurate statement is the
2.4-based kernels included in Red Hat Linux 7.1, 7.2, 7.3 and Red Hat
Linux Advanced Server 2.1 support the hardware extensions that support up
to 64GB of RAM. This is an important distinction: while the hardware will
indeed support up to 64GB of physical memory, the operating system design
limits the supported physical memory to approximately 16GB."

(http://www.redhat.com/services/techsupport/production/GSS_caveat.html)
What are the "operating system design limits" that restrict the amount of
supported memory to 16GB?
-- 
Cheers, Stephen Rothwell                   sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264606AbTFUOBT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264730AbTFUOBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:01:19 -0400
Received: from heat.prim.hu ([195.228.75.76]:49577 "EHLO heat.prim.hu")
	by vger.kernel.org with ESMTP id S264606AbTFUOBQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:01:16 -0400
From: =?iso-8859-2?Q?Fekete_Kriszti=E1n?= <chriss@webmail.hu>
To: linux-kernel@vger.kernel.org
Reply-To: =?iso-8859-2?Q?Fekete_Kriszti=E1n?= <chriss@webmail.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: PrimPosta
Subject: PROBLEM: rootfs problem on cd-rom
Message-Id: <E19Tj9B-0002q9-00@armada.prim.hu>
Date: Sat, 21 Jun 2003 16:15:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried to create a standard live cd to scan for viruses with a 
popular linux antivirus software. At first I have tried with the 
2.4.18-bf2.4 precomplied kernel, and it was fine. I have tried with 
2.4.20-bf2.4, but it was wrong. I have downloaded the 2.4.18,2.4.20 
and 
2.4.21 kernel sources, and tried to complile it to boot the kernel and 
the 
rootfs from cdrom. The 2.4.18 kernel, with the standard config was 
fine, 
it was booted. The 2.4.20 and 2.4.21 kernel with the same config has 
fail.

The 2.4.20, and 2.4.21 said: Kernel Panic, VFS: Unable to find root fs 
on 
"hdb".

Thx.: 

Krisztian Fekete

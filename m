Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130682AbQKVFGh>; Wed, 22 Nov 2000 00:06:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132318AbQKVFGS>; Wed, 22 Nov 2000 00:06:18 -0500
Received: from [203.200.144.37] ([203.200.144.37]:56080 "HELO
	nest.stpt.soft.net") by vger.kernel.org with SMTP
	id <S130682AbQKVFGO>; Wed, 22 Nov 2000 00:06:14 -0500
Organization: NeST India
Message-ID: <F6E1228667B6D411BAAA00306E00F2A520D00B@pdc2.nestec.net>
From: MOHAMMED AZAD <mohammedazad@nestec.net>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Locking User memory pages from a driver....
Date: Wed, 22 Nov 2000 10:05:26 +0530
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

How do i lock user mode memmory pages from kernel mode driver.. so that i
can access it whenever i need to from the driver.... I am using linux kernel
2.2.14.. can this be done in this kernel version... or is it supported in
some other newer versions.. like 2.4..

TIA
azad
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

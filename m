Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132585AbQLJBYw>; Sat, 9 Dec 2000 20:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132642AbQLJBYm>; Sat, 9 Dec 2000 20:24:42 -0500
Received: from manos.timpanogas.org ([207.109.151.249]:41988 "EHLO
	manos.timpanogas.org") by vger.kernel.org with ESMTP
	id <S132585AbQLJBYd>; Sat, 9 Dec 2000 20:24:33 -0500
Date: Sat, 9 Dec 2000 18:49:48 -0700
From: root <root@manos.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: 2.2.18-26 pre-patch has error
Message-ID: <20001209184948.A7029@manos.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Saw the following in the 2.2.18 pre-patch when I attempted to apply it 
to a 2.2.17 kernel

--------------------------
|diff -u --new-file --recursive --exclude-from /usr/src/exclude v2.2.17/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
|--- v2.2.17/arch/i386/vmlinux.lds      Wed May  3 21:22:13 2000
|+++ linux/arch/i386/vmlinux.lds        Sat Dec  9 21:23:21 2000
--------------------------
File to patch:
Skip this patch? [y]
1 out of 1 hunk ignored

Jeff
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

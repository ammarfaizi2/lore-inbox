Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbQKIKfi>; Thu, 9 Nov 2000 05:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQKIKf3>; Thu, 9 Nov 2000 05:35:29 -0500
Received: from ns1.crl.go.jp ([133.243.3.1]:31434 "EHLO ns1.crl.go.jp")
	by vger.kernel.org with ESMTP id <S129450AbQKIKfQ>;
	Thu, 9 Nov 2000 05:35:16 -0500
Date: Thu, 9 Nov 2000 19:35:13 +0900 (JST)
From: Tom Holroyd <tomh@po.crl.go.jp>
To: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: memory.c:83: bad pmd 0000000000000001.
Message-ID: <Pine.LNX.4.30.0011091931270.4448-100000@holly.crl.go.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alpha, 2.4.0-test10.

kernel: memory.c:83: bad pmd 0000000000000001.

Happened right when I ^Ced a vmstat that had been running all day, but
that could be coincidence.

It must be Florida's fault.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

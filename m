Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131630AbRAGUJt>; Sun, 7 Jan 2001 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135211AbRAGUJk>; Sun, 7 Jan 2001 15:09:40 -0500
Received: from igor.alcpress.com ([206.190.136.130]:10002 "HELO
	igor.alcpress.com") by vger.kernel.org with SMTP id <S131630AbRAGUJb>;
	Sun, 7 Jan 2001 15:09:31 -0500
From: ed@alcpress.com
To: linux-kernel@vger.kernel.org
Date: Sun, 7 Jan 2001 12:14:23 -0800
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: ipchains vs netfilter performance
Reply-To: ed@alcpress.com
Message-ID: <3A585D9F.21907.1452FA04@localhost>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that my Linux boxes take quite a hit in terms of
packets per second rate when I define ipchains rules with
2.2.X kernels. Does the netfilter replacement found in 2.4
kernels improve this performance?

11101101 (Ed)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

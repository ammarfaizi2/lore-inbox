Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131095AbQKNNX4>; Tue, 14 Nov 2000 08:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131127AbQKNNXq>; Tue, 14 Nov 2000 08:23:46 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:48396 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S131095AbQKNNXe>;
	Tue, 14 Nov 2000 08:23:34 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [RFC] modutils security cleanup
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 14 Nov 2000 23:53:28 +1100
Message-ID: <6677.974206408@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like a review of modutils 2.3.20 changes before issuing the new
version.  There are two patch sets, the first is all the non-security
patches for 2.3.20, the second is all the security changes.

ftp://ftp.ocs.com.au/pub/patch-modutils-2.3.20-1.gz (non-security)
ftp://ftp.ocs.com.au/pub/patch-modutils-2.3.20-2.gz (security)

Apply against 2.3.19, in that order.

I have not tested 2.3.20-1 against sparc yet, too busy.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

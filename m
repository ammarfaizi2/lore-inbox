Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132168AbQKVCEZ>; Tue, 21 Nov 2000 21:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132183AbQKVCEP>; Tue, 21 Nov 2000 21:04:15 -0500
Received: from www.ylenurme.ee ([193.40.6.1]:27385 "EHLO ylenurme.ee")
	by vger.kernel.org with ESMTP id <S132168AbQKVCED>;
	Tue, 21 Nov 2000 21:04:03 -0500
Date: Wed, 22 Nov 2000 03:33:50 +0200 (GMT-2)
From: Elmer Joandi <elmer@ylenurme.ee>
To: linux-kernel@vger.kernel.org
Subject: reiserfs lockup 2.4.0-t11 SMP.
Message-ID: <Pine.LNX.4.10.10011220324570.2611-100000@yle-server.ylenurme.sise>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


SMP Dual celeron, 128MB ram, 3.6GB part newly created, untar'ing 1GB
newsspool, gave kreiserfsd priority -19, got not very easily reproducible
lockup. 
Sysreq showd kreiserfsd running in state L-TLB or something.

elmer.



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

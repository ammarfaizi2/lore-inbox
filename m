Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRAPXf7>; Tue, 16 Jan 2001 18:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbRAPXft>; Tue, 16 Jan 2001 18:35:49 -0500
Received: from stud3.tuwien.ac.at ([193.170.75.13]:39173 "EHLO
	stud3.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S129749AbRAPXfn>; Tue, 16 Jan 2001 18:35:43 -0500
Date: Wed, 17 Jan 2001 00:35:39 +0100 (MET)
From: Stefan Ring <e9725446@student.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: 2.0.37 crashes immediately
Message-ID: <Pine.HPX.4.10.10101170034180.6998-100000@stud3.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.0.37+ kernels crash even before I can see the "Uncompressing linux..."
message. I use the same configuration for 2.0.36 and 2.0.37 (basically
it's the default configuration without anything interesting changed), and
the latter just won't work. It also doesn't matter if I use zImage or
bzImage. Kernel compiled with a stock redhat 4.2 (gcc 2.7.2.1). My machine
configuration is as follows:

ASUS CUBX-E MB
PIII Coppermine
512MB SDRAM
3c905-tx
guillemot tnt2 m64
ibm dtla-307030 & 305020, quantum fireball ex 6.4

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130247AbQLRNQN>; Mon, 18 Dec 2000 08:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132110AbQLRNQE>; Mon, 18 Dec 2000 08:16:04 -0500
Received: from dwdmx2.dwd.de ([141.38.2.10]:28709 "HELO dwdmx2.dwd.de")
	by vger.kernel.org with SMTP id <S131487AbQLRNP6>;
	Mon, 18 Dec 2000 08:15:58 -0500
Date: Mon, 18 Dec 2000 13:45:23 +0100 (MET)
From: Holger Kiehl <Holger.Kiehl@dwd.de>
To: linux-kernel@vger.kernel.org
Subject: Why is LINK_MAX so low?
Message-Id: <Pine.LNX.4.10.10012181336440.4711-100000@diagnostix.dwd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Why is LINK_MAX in linux only 127? The values for other operating
systems is as follows:

   solaris  32767
   hpux     32767
   irix     30000

In reallity LINK_MAX for ext2 is 32000, so why is this only 127?

Please cc to me since I am not on this list.

Thanks,
Holger

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132052AbQKKT21>; Sat, 11 Nov 2000 14:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132284AbQKKT2R>; Sat, 11 Nov 2000 14:28:17 -0500
Received: from lina.inka.de ([212.227.16.17]:46890 "EHLO matrix.inka.de")
	by vger.kernel.org with ESMTP id <S132257AbQKKT2H>;
	Sat, 11 Nov 2000 14:28:07 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Missing ACKs with Linux 2.2/2.4?
Message-Id: <E13ugIb-0004jA-00@calista.inka.de>
Date: Sat, 11 Nov 2000 20:26:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.30.0011101435140.11937-100000@artemis.cam.zeus.com> you wrote:
> The cobalt machines have now had a kernel upgrade (only to 2.2.14, thats
> the most recent that Cobalt provide...), and the problem has
> disappeared.

Should we ignore "timestamp 0" if there are systems out there which will
break on that. Or is timestamp 0 a legal value?

Greetings
Bernd
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

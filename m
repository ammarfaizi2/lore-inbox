Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130643AbQLaDLC>; Sat, 30 Dec 2000 22:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbQLaDKw>; Sat, 30 Dec 2000 22:10:52 -0500
Received: from mout1.freenet.de ([194.97.50.132]:6799 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S131023AbQLaDKi>;
	Sat, 30 Dec 2000 22:10:38 -0500
From: mkloppstech@freenet.de
Message-Id: <200012310240.DAA10504@john.epistle>
Subject: strange behaviour with test13-pre6
To: linux-kernel@vger.kernel.org
Date: Sun, 31 Dec 2000 03:40:13 +0100 (CET)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With test13-pre6 I suddenly found that I could not change the console.
When I wanted to enter a command letters were changed:
greek \mu appeared for m,
tilde n for e.

After a few seconds the system returned to normal behaviour.
No messages can be found in the logfiles.

Please cc to mkloppstech@freenet.de

Mirko Kloppstech
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129532AbRAVIFa>; Mon, 22 Jan 2001 03:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbRAVIFU>; Mon, 22 Jan 2001 03:05:20 -0500
Received: from smtp3.jp.psi.net ([154.33.63.113]:64786 "EHLO smtp3.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129532AbRAVIFF>;
	Mon, 22 Jan 2001 03:05:05 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Is this kernel related (signal 11)?
Date: Mon, 22 Jan 2001 17:03:54 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGOEKCCNAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.30.0101220725550.8352-100000@imladris.demon.co.uk>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Would this be an SMP IA32 box with glibc 2.2? I have two such boxen
> showing exactly the same behaviour, although I can't reproduce it at will.

Close, it is actually an SMP IA32 box with glibc 2.1.3. But you've now
convinced me to not upgrade glibc yet  ;-)

--Rainer

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

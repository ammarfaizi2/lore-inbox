Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136162AbRA1AyR>; Sat, 27 Jan 2001 19:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136161AbRA1AyG>; Sat, 27 Jan 2001 19:54:06 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:27916
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S136132AbRA1Axt>; Sat, 27 Jan 2001 19:53:49 -0500
Date: Sat, 27 Jan 2001 16:53:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: linux-kernel@vger.kernel.org
Subject: SMP Athlon...(a quiet question)
Message-ID: <Pine.LNX.4.10.10101271650170.25882-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ER, they work but must compile as PII/Celeron :-(
A bunch of memcpy header stuff fails to compile....
current is one of the left overs in some cases.

I will dive deeper in monday, just wanting some feed back first.

Cheers,

Andre Hedrick
Linux ATA Development

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

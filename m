Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131602AbQKVD4v>; Tue, 21 Nov 2000 22:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131801AbQKVD4k>; Tue, 21 Nov 2000 22:56:40 -0500
Received: from JJG202.rh.psu.edu ([128.118.128.47]:22289 "HELO
	dilbert.wizard.dok.org") by vger.kernel.org with SMTP
	id <S131602AbQKVD40>; Tue, 21 Nov 2000 22:56:26 -0500
From: "Joseph Gooch" <mrwizard@psu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: ECN causing problems
Date: Tue, 21 Nov 2000 22:26:24 -0500
Message-ID: <006301c05433$feb8c0c0$0200020a@wizws>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My RaptorNT 6.5 firewall rejects all connections from my linux box when ECN
is enabled.  The error is attached.  Perhaps this feature should be disabled
by default?  Or is there already an option of the sort that i'm missing?  I
only got the idea to disable it after a search of linux-kernel.

Plz cc me, I"m not on the list.

Later!
Joe Gooch

TCP packet dropped (10.204.186.7->x.x.x.x: Protocol=TCP[SYN 0xc0] Port
1255->2401): Bad TCP flags combination (received on interface 192.168.1.1)
(probable QueSO probe as flags=0xc2)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

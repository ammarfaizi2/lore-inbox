Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129825AbRAOAeh>; Sun, 14 Jan 2001 19:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129965AbRAOAe1>; Sun, 14 Jan 2001 19:34:27 -0500
Received: from venus.it.swin.edu.au ([136.186.2.21]:9994 "EHLO
	venus.it.swin.edu.au") by vger.kernel.org with ESMTP
	id <S129825AbRAOAeK>; Sun, 14 Jan 2001 19:34:10 -0500
Message-ID: <3A6252FE.B619EE8A@it.swin.edu.au>
Date: Mon, 15 Jan 2001 11:31:43 +1000
From: John Newbigin <jn@it.swin.edu.au>
Reply-To: jn@it.swin.edu.au
Organization: Swinburne University of Technology
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en,ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: binary garbage in dmesg/boot messages (2.4.0)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With kernel 2.4.0 on a Compaq DL380 I get the following. All seems OK
except for the Version string.  I have not checked the serial number but
I looks acceptable.  I do not know what the correct version string
should be either.

Jan 11 17:11:37 cartman kernel: DMI 2.3 present.
Jan 11 17:11:37 cartman kernel: 25 structures occupying 842 bytes.
Jan 11 17:11:37 cartman kernel: DMI table at 0x000FF066.
Jan 11 17:11:37 cartman kernel: BIOS Vendor: Compaq
Jan 11 17:11:37 cartman kernel: BIOS Version: P17
Jan 11 17:11:37 cartman kernel: BIOS Release: 12/13/1999
Jan 11 17:11:37 cartman kernel: System Vendor: Compaq.
Jan 11 17:11:38 cartman kernel: Product Name: ProLiant DL380.
Jan 11 17:11:38 cartman kernel: Version ^Cu^IP¸^E¿³^AÍ^PXö^F^X.
Jan 11 17:11:38 cartman kernel: Serial Number H030FD419124    .

John.


--
Information Technology Innovation Group
Swinburne University. Melbourne, Australia
http://uranus.it.swin.edu.au/~jn


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

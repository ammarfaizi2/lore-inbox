Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRBJUhu>; Sat, 10 Feb 2001 15:37:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129258AbRBJUha>; Sat, 10 Feb 2001 15:37:30 -0500
Received: from smtp-rt-2.wanadoo.fr ([193.252.19.154]:50394 "EHLO
	apeiba.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129143AbRBJUh0>; Sat, 10 Feb 2001 15:37:26 -0500
Message-ID: <3A85A692.E3FE8DAF@wanadoo.fr>
Date: Sat, 10 Feb 2001 21:37:38 +0100
From: Jean-luc Coulon <jean-luc.coulon@wanadoo.fr>
Organization: personal system
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.2.19pre9 i586)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Power off 2.4.xx and ACPI / APM
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've read some messages some time ago about problems related to ACPI.
But I've not found the clue to my problem.

With kernel 2.2.19 and APM enabled, the power supply switches off while
the message Power down appears.

With 2.4.x, nothing occurs. I've to enable ACPI too to have this
behaviour.

But if I enable ACPI, I've a strange problem with my AX25 (hamradio)
system :
all the frames I send on the radio network are _very_ long without any
data in it. The watchdog of the card (DRSI : works with the scc driver),

switches the transmitter off after few seconds.

Any idea ?

----

Regards

  Jean-Luc

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

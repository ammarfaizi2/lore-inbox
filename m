Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132704AbRDIIbb>; Mon, 9 Apr 2001 04:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132705AbRDIIbM>; Mon, 9 Apr 2001 04:31:12 -0400
Received: from [62.90.5.51] ([62.90.5.51]:40463 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S132704AbRDIIbJ>;
	Mon, 9 Apr 2001 04:31:09 -0400
Message-ID: <F1629832DE36D411858F00C04F24847A11DF71@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'Bernhard Bender'" <Bernhard.Bender@ELSA.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: ethernet phy link state info
Date: Mon, 9 Apr 2001 11:36:50 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You need to use diagnostic or setup utility of that specific device, the
utility usually comes with the specific driver using the driver to receive
info about mii registers (the registers in charge of full/half 10/100 etc').

you can find many drivers and diagnostic utilities at http://www.scyld.com/.

Ofer

-----Original Message-----
From: Bernhard Bender [mailto:Bernhard.Bender@ELSA.de]
Sent: Friday, April 06, 2001 4:55 PM
To: linux-kernel@vger.kernel.org
Subject: ethernet phy link state info




Hi all,

where do I find information about the current link state of the ethernet PHY
(e.g. 100mbit/s full duplex) ?
Something like /proc/sys/net/* ?

Thanks
Bernhard


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

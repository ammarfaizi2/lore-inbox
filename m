Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132628AbRC2KQ6>; Thu, 29 Mar 2001 05:16:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132662AbRC2KQs>; Thu, 29 Mar 2001 05:16:48 -0500
Received: from [62.90.5.51] ([62.90.5.51]:42252 "EHLO salvador.shunra.co.il")
	by vger.kernel.org with ESMTP id <S132628AbRC2KQc>;
	Thu, 29 Mar 2001 05:16:32 -0500
Message-ID: <F1629832DE36D411858F00C04F24847A11DF3B@SALVADOR>
From: Ofer Fryman <ofer@shunra.co.il>
To: "'Jean-Michel Lee'" <thaz@21cn.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Question: is linux support Intel's i840 chipset?
Date: Thu, 29 Mar 2001 12:20:33 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2448.0)
Content-Type: text/plain;
	charset="WINDOWS-1255"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe that Linux 2.2.x and 2.4.x do support it well, however I tried
using it with Linux 2.0.x and it caused me many problems with PCI drivers. I
also tried server-works chipset, which also works with 64-bit PCI bus, it
worked well under Linux 2.0.x no problems what so ever.
Any way since the 840 chipset is known to be buggy, I suggest you use
server-works.

Ofer

-----Original Message-----
From: Jean-Michel Lee [mailto:thaz@21cn.com]
Sent: Thursday, March 29, 2001 11:47 AM
To: linux-kernel@vger.kernel.org
Subject: Question: is linux support Intel's i840 chipset?


Hi,

I just want to search a mainboard with 64-bit PCI bus and ATA-100 support. I
just find that Intel i840 do. So, I wonder whether linux support Intel's
i840.

Thanks.

Michel

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

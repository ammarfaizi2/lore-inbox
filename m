Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSKKBdi>; Sun, 10 Nov 2002 20:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbSKKBdi>; Sun, 10 Nov 2002 20:33:38 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:8208 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265320AbSKKBdh>; Sun, 10 Nov 2002 20:33:37 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1894@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'knobi@knobisoft.de'" <knobi@knobisoft.de>, linux-kernel@vger.kernel.org
Subject: RE: Memory performance on Serverworks GC-LE based system poor?
Date: Sun, 10 Nov 2002 17:39:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You must have done this, but just wanted to confirm. Did you check the Front
Side Bus speed in the BIOS? 

Thanks
Manish

-----Original Message-----
From: Martin Knoblauch [mailto:knobi@knobisoft.de]
Sent: Sunday, November 10, 2002 4:30 PM
To: linux-kernel@vger.kernel.org
Subject: Memory performance on Serverworks GC-LE based system poor?


Hi,

 I have experienced extreme low STREAMS numbers (about 600 MB/sec for Triad)

on two dual CPU systems based on the ServerWorks GC-LE chipset (SuperMicro 
P4DLR+ mainboard). Both systems had 2x2.4 GHz XEONs, 4GB of DDR memory and 
were running kernel 2.4.18. I would usually expect STREAMS numbers of about 
2000 MB/sec for this kind of systems.

Does this ring any bells?

Martin
-- 
----------------------------------
Martin Knoblauch
knobi@knobisoft.de
http://www.knobisoft.de
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

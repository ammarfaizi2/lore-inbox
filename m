Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265143AbSKVSTA>; Fri, 22 Nov 2002 13:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265180AbSKVSTA>; Fri, 22 Nov 2002 13:19:00 -0500
Received: from imrelay-2.zambeel.com ([209.240.48.8]:9736 "EHLO
	imrelay-2.zambeel.com") by vger.kernel.org with ESMTP
	id <S265143AbSKVSS7> convert rfc822-to-8bit; Fri, 22 Nov 2002 13:18:59 -0500
Message-ID: <233C89823A37714D95B1A891DE3BCE5202AB1994@xch-a.win.zambeel.com>
From: Manish Lachwani <manish@Zambeel.com>
To: "'Emiliano Gabrielli'" <Emiliano.Gabrielli@roma2.infn.it>,
       linux-kernel@vger.kernel.org
Subject: RE: i7500 and IRQ assignment
Date: Fri, 22 Nov 2002 10:25:49 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experienced the same problem with Supermicro and Intel E7500 board. Look
on 

http://sourceforge.net/projects/lse

for the apic routing patch. This patch, when applied, will solve the issue 

-----Original Message-----
From: Emiliano Gabrielli [mailto:Emiliano.Gabrielli@roma2.infn.it]
Sent: Friday, November 22, 2002 8:05 AM
To: linux-kernel@vger.kernel.org
Subject: i7500 and IRQ assignment



I can find a patch for the i7500 chipset IRQ problem.
Is it still unsolved ? ... I have a full custom PCI device that does not 
receive an IRQ...

Any suggestion ?? 

tnx in advance

-- 
Emiliano Gabrielli

dip. di Fisica
2° Università di Roma "Tor Vergata"

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

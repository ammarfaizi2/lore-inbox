Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130653AbQLHQPV>; Fri, 8 Dec 2000 11:15:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131382AbQLHQPM>; Fri, 8 Dec 2000 11:15:12 -0500
Received: from bryant.dsc.k12.ar.us ([165.29.94.240]:46854 "HELO
	bryant.k12.ar.us") by vger.kernel.org with SMTP id <S130653AbQLHQOv>;
	Fri, 8 Dec 2000 11:14:51 -0500
From: "Barry Smoke" <bsmoke@bryant.dsc.k12.ar.us>
To: <linux-kernel@vger.kernel.org>
Subject: rage 128 mobility m/p and kernel DRI
Date: Fri, 8 Dec 2000 10:23:50 -0600
Message-ID: <IMEKIDMFAEBICGFFGJPKAENDCPAA.bsmoke@bryant.k12.ar.us>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a development kernel with DRI for the ati rage 128 mobility m/p
processor?
DRI is available for the rage 128, but it is not working on this chipset.
This seems to be the only way to get hardware acceleration working on
XFree86 4.0, without reverting back to 3
The attempted compile of this was on a debian woody dist, with x4.0
I tried the current kernel 2.4.0-test11
Windows reports the chip as a rage mobility-p agp 1x, agp2x

I am not subscribed to this list, so...
Please reply to:
barry@arhosting.com

Thanks,
Barry Smoke
Network Administrator
Bryant Public Schools

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

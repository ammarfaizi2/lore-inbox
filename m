Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136173AbRBFBi4>; Mon, 5 Feb 2001 20:38:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136241AbRBFBir>; Mon, 5 Feb 2001 20:38:47 -0500
Received: from home2.meteo.yu ([194.247.208.23]:23817 "HELO
	c00l.home.lucidtech.org") by vger.kernel.org with SMTP
	id <S136173AbRBFBim>; Mon, 5 Feb 2001 20:38:42 -0500
From: "Vladimir Kukuruzovic" <kuki@sezampro.yu>
To: <linux-kernel@vger.kernel.org>
Subject: hpt370
Date: Tue, 6 Feb 2001 02:38:29 +0100
Message-ID: <NEBBKCIPKLPNDBIKKMBACENIFFAA.kuki@sezampro.yu>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V5.00.2919.6700
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Maybe you don't know, but current Linux kernel (starting somewhere in
testNN, probably test10 series) won't boot with HPT370 controller. With
current setup (only one disk on that controller, no raid, no fancy stuff)
the kernel locks after writing ide2: line :( Well, it used to work earlier,
can it be unpatched so it starts working again? :)

Regards, Vladimir

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

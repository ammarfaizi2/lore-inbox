Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261283AbTC3Nf5>; Sun, 30 Mar 2003 08:35:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261293AbTC3Nf5>; Sun, 30 Mar 2003 08:35:57 -0500
Received: from keetweej.xs4all.nl ([213.84.46.114]:384 "EHLO
	muur.intranet.vanheusden.com") by vger.kernel.org with ESMTP
	id <S261283AbTC3Nf5>; Sun, 30 Mar 2003 08:35:57 -0500
From: "Folkert van Heusden" <folkert@vanheusden.com>
To: <linux-kernel@vger.kernel.org>
Subject: eth2: Error -110 writing Tx descriptor to BAP
Date: Sun, 30 Mar 2003 15:47:14 +0200
Message-ID: <012101c2f6c2$dfddd260$3640a8c0@boemboem>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2910.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm getting ziliions of
eth2: Error -110 writing Tx descriptor to BAP
in the output of dmesg.
With 2 cards from different brands.
Modules I'm using:
orinoco_plx             3200   1
orinoco                32176   0 [orinoco_plx]
hermes                  6448   0 [orinoco_plx orinoco]
kernel 2.4.20

What does this error mean? And is it the cause
of the bad data-transmissions I get? (it's so slow, it
's useless)


Folkert

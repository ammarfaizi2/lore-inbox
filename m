Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132119AbRARVxA>; Thu, 18 Jan 2001 16:53:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136030AbRARVwm>; Thu, 18 Jan 2001 16:52:42 -0500
Received: from sanrafael.dti2.net ([195.57.112.5]:29450 "EHLO dti2.net")
	by vger.kernel.org with ESMTP id <S132754AbRARVwj>;
	Thu, 18 Jan 2001 16:52:39 -0500
Message-ID: <001c01c08199$387205f0$067039c3@cintasverdes>
From: "Jorge Boncompte \(DTI2\)" <jorge@dti2.net>
To: <linux-kernel@vger.kernel.org>
Subject: ERR in /proc/interrupts
Date: Thu, 18 Jan 2001 22:54:24 +0100
Organization: DTI2 - Desarrollo de la Tecnología de las Comunicaciones
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    What does ERR mean in /proc/interrupts? I have a computer running
2.4.0test12 that has a lot of this ERR's?

           CPU0
  0:  116445752          XT-PIC  timer
  1:     389614          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  5:   34298837          XT-PIC  eth1
  8:          1          XT-PIC  rtc
 10:  400182075          XT-PIC  eth0
 11:   23181909          XT-PIC  ide0, ide1
 14:          4          XT-PIC  ide2
 15:     692215          XT-PIC  ide3
 64:          0            none  acpi
NMI:          0
ERR:    1586756

This is an AMD 800 + Tyan K7 mobo.

    -Jorge

==============================================================
Jorge Boncompte - Técnico de sistemas
DTI2 - Desarrollo de la Tecnología de las Comunicaciones
--------------------------------------------------------------
C/ Abogado Enriquez Barrios, 5   14004 CORDOBA (SPAIN)
Tlf: +34 957 761395 / FAX: +34 957 450380
--------------------------------------------------------------
jorge@dti2.net _-_-_-_-_-_-_-_-_-_-_-_-_-_ http://www.dti2.net
==============================================================
Without wicker a basket cannot be done.
==============================================================


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

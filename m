Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268384AbRGXRdm>; Tue, 24 Jul 2001 13:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268383AbRGXRdd>; Tue, 24 Jul 2001 13:33:33 -0400
Received: from [145.254.150.103] ([145.254.150.103]:772 "HELO
	ozean.schottelius.org") by vger.kernel.org with SMTP
	id <S268381AbRGXRdS>; Tue, 24 Jul 2001 13:33:18 -0400
Message-ID: <3B5DB12D.2B9C205E@pcsystems.de>
Date: Tue, 24 Jul 2001 19:32:29 +0200
From: Nico Schottelius <nicos@pcsystems.de>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: ps2/ new data for mouse protocol (fwd msg attached)
Content-Type: multipart/mixed;
 boundary="------------BCC883D8927006EF7A14E2D6"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

This is a multi-part message in MIME format.
--------------BCC883D8927006EF7A14E2D6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit



Hello guys!

Have a look into the attached email before reading mine, please.

Is it possible to find out about what those bytes are ?
And is it possible to intergrate the support for other
3 bytes into the Linux kernel ?


Sincerly,

Nico


--------------BCC883D8927006EF7A14E2D6
Content-Type: message/rfc822;
 name="nsmail3B5DB10E002019E"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="nsmail3B5DB10E002019E"

Return-Path: <fzawde@synaptics.com>
Delivered-To: nico@schottelius.org
Received: (qmail 2838 invoked by uid 0); 15 Mar 2001 18:19:19 -0000
Received: from dns.pcsystems.de (HELO pcsystems.de) (212.63.44.1)
  by www.schottelius.org with SMTP; 15 Mar 2001 18:19:19 -0000
Received: (qmail 18453 invoked by uid 577); 15 Mar 2001 18:23:46 -0000
Delivered-To: nicos@pcsystems.de
Received: (qmail 18450 invoked by uid 0); 15 Mar 2001 18:23:45 -0000
Received: from synaptics-gw.synaptics.com (HELO synaptics.com) (216.90.168.181)
  by dns.pcsystems.de with SMTP; 15 Mar 2001 18:23:45 -0000
Received: from synaptx (localhost [127.0.0.1])
	by synaptics.com (8.8.7/8.8.7) with SMTP id KAA06393
	for <nicos@pcsystems.de>; Thu, 15 Mar 2001 10:32:58 -0800 (PST)
Received: from DHVR0D01 by synaptx (SMI-8.6/SMI-SVR4)
	id KAA28654; Thu, 15 Mar 2001 10:27:02 -0800
Reply-To: <fzawde@synaptics.com>
From: "Fidel Zawde" <fzawde@synaptics.com>
To: <nicos@pcsystems.de>
Subject: FW: informations needed of touchpad
Date: Thu, 15 Mar 2001 10:21:22 -0800
Message-ID: <IGEJKLBCLBNKEDPBHJPFEEEOCAAA.fzawde@synaptics.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mozilla-Status2: 00000000

Hello,

In order to use four buttons the data packages must be larger than the
standard 3 bytes.  The data packages that the touchpad sends in absolute
mode is 6 bytes.  The information on how the buttons are inserted into the 6
byte packet is proprietary.  However, if you would like more information on
the data packets that are sent from the touchpad you can download the
"Synaptics Touchpad Interfacing guide" from our website www.synaptics.com.

I hope this helps,
Fidel Zawde


-----Original Message-----
From: Nico Schottelius [mailto:nicos@pcsystems.de]
Sent: Thursday, March 15, 2001 2:48 AM
To: info@synaptics.com
Subject: informations needed of touchpad


Hello!

Can you explain to me, how you inserted 4 buttons into the Ps2 Protocol
?
I am talking of the touchpad used in the Acer Travelmate 524 TEV.
I want to get access to the four buttons under Linux.

Sincerly,

Nico Schottelius




--------------BCC883D8927006EF7A14E2D6--


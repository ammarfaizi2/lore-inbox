Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281927AbRKUSQr>; Wed, 21 Nov 2001 13:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281940AbRKUSQh>; Wed, 21 Nov 2001 13:16:37 -0500
Received: from nugate.perceptive.se ([62.168.142.2]:10574 "EHLO
	piff.i.perceptive.se") by vger.kernel.org with ESMTP
	id <S281927AbRKUSQ3> convert rfc822-to-8bit; Wed, 21 Nov 2001 13:16:29 -0500
content-class: urn:content-classes:message
Subject: Network card timeouts
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Date: Wed, 21 Nov 2001 19:16:23 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
Message-ID: <71C83C8929F73A40BBD0C137232DD1972ED4@piff.i.perceptive.se>
Thread-Topic: Network card timeouts
Thread-Index: AcFyuKAX+DS6NjuHTxyMmnFryok6vg==
From: "Anders Linden" <anli@perceptive.se>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Symptom:
Network cards that stops working if they are sent enough data.

The cards I have got problem with this far:
Intel Etherexpress Pro 100+ (some kernels ago).
Davicom Semiconductor, Inc. Ethernet 100/10

Occasion 1:
The kernel version on the computers were 2.4.3. Every person in a single
classroom had problem with Intel cards. They could not even fetch
webpages before their consoles were spammed with a message like: network
card timeout. All computers were Compaq. I dont know which hardware they
had in addition to that. I have also had problems with Intel cards even
after this occasion on other computers.

Occasion 2:
The later card, Davicom, is probably not a well-known card, but
nevertheless, it works like shit in Linux. I am using Redhat 7.1 and the
kernel 2.4.2-2. If I send more than 10M to such a card in an interval of
a second, it just quits working for 5 seconds. The card has no problems
at all in other, third party operating systems, like Windows.


Is it the newest kernels that has theese problems? The first occasion
was exactly after a kernel 2.4.3 has been released, and people I talked
to said that 2.4.2 and network cards were better friends.


Thanks for your attension

/Anders Lindén

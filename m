Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbSLFPSM>; Fri, 6 Dec 2002 10:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263228AbSLFPSM>; Fri, 6 Dec 2002 10:18:12 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:3995 "EHLO gatekeeper.slim")
	by vger.kernel.org with ESMTP id <S263215AbSLFPSK>;
	Fri, 6 Dec 2002 10:18:10 -0500
Subject: [2.4.20] Problems with yenta PCMCIA socket (worked with 2.4.19)
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1039188438.1794.5.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-1) 
Date: 06 Dec 2002 16:27:18 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Today I tried various versions of the 2.4.20 kernel but all had
trouble with my PCMCIA controller in my mobile mini-note PC. It has
a Ricoh RL5C476 II (rev 88) according to lspci. With 2.4.20 it gives
my "Resource unavailable" messages when a plug in my hermes/orinoco
based wireless lan card. There hasn't been any changes in the PCMCIA
code between 2.4.19 and 2.4.20. What can be the problem? ACPI related?

If you need more info let me know.

Cheers,

Jurgen



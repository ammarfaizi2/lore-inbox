Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271714AbRH0N16>; Mon, 27 Aug 2001 09:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271720AbRH0N1t>; Mon, 27 Aug 2001 09:27:49 -0400
Received: from mustard.heime.net ([194.234.65.222]:11136 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S271714AbRH0N1n>; Mon, 27 Aug 2001 09:27:43 -0400
Date: Mon, 27 Aug 2001 15:27:58 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
To: <linux-kernel@vger.kernel.org>
cc: Jannik Rasmussen <jannik@east.no>
Subject: Error 3c900 driver in 2.2.19?
Message-ID: <Pine.LNX.4.30.0108271523560.921-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have a 3c900 card in a server, and after upgrading to 2.2.19 it started
hanging every now and then, giving me the error message "kernel: eth0:
memory shortage". The card is this (as reported during boot)

3c59x.c:v0.99H 27May00 Donald Becker
http://cesdis.gsfc.nasa.gov/linux/drivers/vortex.html
eth0: 3Com 3c900 Boomerang 10Mbps Combo at 0xa800,  00:a0:24:ef:ef:50, IRQ 5
  8K word-wide RAM 3:5 Rx:Tx split, 10baseT interface.
  Enabling bus-master transmits and whole-frame receives.

Please cc: to me (roy@karlsbakk.net) and Jannik (jannik@east.no), as we're
not on the list.

Best regards

roy


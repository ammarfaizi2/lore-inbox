Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSLAT7p>; Sun, 1 Dec 2002 14:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSLAT7p>; Sun, 1 Dec 2002 14:59:45 -0500
Received: from d10-262.dialup.ncport.ru ([213.134.222.10]:3076 "EHLO ask-me.ru")
	by vger.kernel.org with ESMTP id <S262289AbSLAT7o>;
	Sun, 1 Dec 2002 14:59:44 -0500
Date: Wed, 27 Nov 2002 23:06:26 +0300
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: PCMCIA 3Com card dies after suspend
Message-ID: <20021127200626.GA581@ask-me.ru>
Mail-Followup-To: =?koi8-r?B?0JzQsNC60YHQuNC8INCb0LDQv9GI0LjQvQ==?= <max@ask-me.ru>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.4.18
From: Max Lapshin <max@ask-me.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo. I have 3CCFE575BT pcmcia network card in my Compaq Armada 7360 DMT.
It dies after suspend with the following messages:

 eth0: command 0x5800 did not complete! Status=0xffff
 eth0: command 0x2804 did not complete! Status=0xffff

Machine is almost blocked during these messages and I need to replug it.
It is really annoying. Donald Becker told me, this is a bug in PCMCIA
code, so I've posted this message here.

P.S. If there will be any answers, please CC me, because I'm not 
subscribed to the list.

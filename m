Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263441AbTK1Ugm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 15:36:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTK1Ugm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 15:36:42 -0500
Received: from slimnet.xs4all.nl ([194.109.194.192]:11454 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S263441AbTK1Ugl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 15:36:41 -0500
Subject: 2.6.0-t11: keyboard problems revisited
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1070051819.11312.16.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 28 Nov 2003 21:36:59 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While booting 2.6.0-t11 into textmode I found out there are still some
problems with the keyboard code.

On my laptop with PS/2 keyboard (Japanese layout) I can't use the key
with the Yen on it (which also has the pipe). All other keys seem to
work OK.

On my PC with USB keyboard (Logitech iTouch) I can't use the "\" key
properly so I can't type "ps -ef | grep blabla" which is not very
helpful is you want to try to investigate problems.

So there seems to be some kind of anti-pipe conspiracy here...;-)

Jurgen
 



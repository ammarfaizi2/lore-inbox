Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261676AbTIZWRa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 18:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261677AbTIZWRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 18:17:30 -0400
Received: from inova102.correio.tnext.com.br ([200.222.67.102]:56266 "HELO
	leia-auth.correio.tnext.com.br") by vger.kernel.org with SMTP
	id S261676AbTIZWR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 18:17:29 -0400
X-Analyze: Velop Mail Shield v0.0.3
Date: Fri, 26 Sep 2003 19:17:24 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Deadlocks using PS/2 and USB keyboards at the same time ?
Message-ID: <Pine.LNX.4.58.0309261906010.236@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just bought 2 keyboards, 1 PS/2 and 1 USB, and plugged both.
On Windows XP both are recognized and work fine. I can hotswap
the USB without any problems. I'm just not sure if Caps Lock
and the other keys light on both is expected. I thought they
were "independent".

But on Linux, with 2.4.22 the USB keyboard just locks when I
load the USB modules, and with 2.6.0-test4 I get deadlocks. I
already got 1 doing a modprobe, and the other ps reported from
khubd.

-- 
How to contact me - http://www.pervalidus.net/contact.html

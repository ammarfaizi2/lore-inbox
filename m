Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261362AbTI3LzF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 07:55:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTI3LzF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 07:55:05 -0400
Received: from docsis152-38.menta.net ([62.57.152.38]:55681 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S261362AbTI3LzA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 07:55:00 -0400
Date: Tue, 30 Sep 2003 13:54:59 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Subject: multimedia keys not working in 2.6.0-test6
Message-ID: <Pine.LNX.4.44.0309301351220.2486-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


These are the messages I get when pressing P1 and P2 in my laptop.

kernel: atkbd.c: Unknown key pressed (translated set 2, code 0x153, data 0x74, on isa0060/serio0).
kernel: atkbd.c: Unknown key released (translated set 2, code 0x153, data 0xf4, on isa0060/serio0).

Email and browser keys report a correct code and I can bind thm to any app 
using xbindkeys, but with thes two there's no way.

I'm running 2.6.0-test6--mm1 with the events patch removed.

Pau


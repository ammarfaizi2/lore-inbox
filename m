Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318043AbSGWMXa>; Tue, 23 Jul 2002 08:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318046AbSGWMXa>; Tue, 23 Jul 2002 08:23:30 -0400
Received: from mx1.elte.hu ([157.181.1.137]:47001 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S318043AbSGWMX3>;
	Tue, 23 Jul 2002 08:23:29 -0400
Date: Tue, 23 Jul 2002 14:25:14 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Thunder from the hill <thunder@ngforever.de>,
       Linus Torvalds <torvalds@transmeta.com>, Dave Jones <davej@suse.de>,
       Maksim Krasnyanskiy <maxk@qualcomm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Bluetooth Subsystem PC Card drivers for 2.5.27
In-Reply-To: <1027425484.26701.2.camel@pegasus>
Message-ID: <Pine.LNX.4.44.0207231424380.9226-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please don't use EXPORT_NO_SYMBOLS where it's avoidable.

why?

other than since it's the default, there's no need to define it in 2.5 
kernels.

	Ingo


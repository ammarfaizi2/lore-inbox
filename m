Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSGVQBe>; Mon, 22 Jul 2002 12:01:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSGVQBe>; Mon, 22 Jul 2002 12:01:34 -0400
Received: from 62-190-216-139.pdu.pipex.net ([62.190.216.139]:27405 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S317662AbSGVQBd>; Mon, 22 Jul 2002 12:01:33 -0400
From: metf28@dial.pipex.com
Message-Id: <200207221610.g6MGA5Dc002733@darkstar.example.net>
Subject: Re: Athlon XP 1800+ segemntation fault
To: karol_olechowski@acn.waw.pl (Karol Olechowski)
Date: Mon, 22 Jul 2002 17:10:05 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1027352789.1655.41.camel@alpha> from "Karol Olechowski" at Jul 22, 2002 05:46:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's something strange with my computer cause not only Linux hangs.On
> the other disk I've got Win XP and it also hangs ( blue screen,memory
> dump and things like that...).Almost every component is a brand
> new(mother board, processor, memory, video card, power supply)

Check the following things:

* Cooling - is the CPU fan, especially, working, and not clogged up with dust

* Memory - try booting Linux with MEM=16M or something - if the problem goes away, it's probably related to memory.  Try removing and re-inserting the RAM, and cleaning the edge connectors, (I had a machine run fine for a couple of years, then suddenly keep failing.  Cleaning the RAM edge connectors fixed it).

* PSU - make sure your power supply is suitable for the new CPU, (rule of thumb being 300+ Watt rating on it).

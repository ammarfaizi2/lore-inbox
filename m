Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261733AbTABMp1>; Thu, 2 Jan 2003 07:45:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTABMp0>; Thu, 2 Jan 2003 07:45:26 -0500
Received: from pop.gmx.de ([213.165.65.60]:37329 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261733AbTABMpZ>;
	Thu, 2 Jan 2003 07:45:25 -0500
Date: Thu, 2 Jan 2003 13:53:50 +0100
From: Marc Giger <gigerstyle@gmx.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Power off a SMP Box
Message-Id: <20030102135350.24315441.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.8.6claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I know this question was already asked 1000 times.

My "problem" is that my Dual-Box won't power off itself after a shutdown.

I tried with 

apm=smp-power-off	//no effect
apm=power-off		//this one oopses on boot

I google'd around many hours with no solution.

Has someone a hint for me?

The Box is a Asus P3C-D with two PIII @ 933 Mhz

Thank you

Marc

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSKEFbh>; Tue, 5 Nov 2002 00:31:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262813AbSKEFbh>; Tue, 5 Nov 2002 00:31:37 -0500
Received: from modemcable074.85-202-24.mtl.mc.videotron.ca ([24.202.85.74]:5130
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S262702AbSKEFbg>; Tue, 5 Nov 2002 00:31:36 -0500
Date: Mon, 4 Nov 2002 23:38:30 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Russell King <rmk@arm.linux.org.uk>
Subject: Re: 2.5.45 odd deref in serial_in 
In-Reply-To: <Pine.LNX.4.44.0211042323410.27141-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0211042337230.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Nov 2002, Zwane Mwaikambo wrote:

> The only modifications to this code are a slightly hacked up nmi watchdog 
> timer.

Not that easy to reproduce, its probably the printk in my nmi handler. 
Sorry, you can ignore this bugreport.

	Zwane
-- 
function.linuxpower.ca


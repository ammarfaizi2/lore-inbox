Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261263AbSKGPS1>; Thu, 7 Nov 2002 10:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSKGPS1>; Thu, 7 Nov 2002 10:18:27 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:38664
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261263AbSKGPS0>; Thu, 7 Nov 2002 10:18:26 -0500
Date: Thu, 7 Nov 2002 10:24:29 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: David Woodhouse <dwmw2@infradead.org>
cc: Russell King <rmk@arm.linux.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45 odd deref in serial_in 
In-Reply-To: <13624.1036682234@passion.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.44.0211071023490.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, David Woodhouse wrote:

> zwane@holomorphy.com said:
> >  I'm runnning 115200 :P 
> 
> Why so slow? Most current chipsets can do at least 230400, usually 460800.

Its an offboard card (netmos), i'll try jacking it up a bit and see if it 
holds up.

	Zwane
-- 
function.linuxpower.ca


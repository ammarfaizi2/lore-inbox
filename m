Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSKYPdQ>; Mon, 25 Nov 2002 10:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264859AbSKYPdQ>; Mon, 25 Nov 2002 10:33:16 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:12464
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S264760AbSKYPdQ>; Mon, 25 Nov 2002 10:33:16 -0500
Date: Mon, 25 Nov 2002 10:43:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Steffen Persvold <sp@scali.com>
cc: Emiliano Gabrielli <Emiliano.Gabrielli@roma2.infn.it>,
       "" <linux-kernel@vger.kernel.org>, Manish Lachwani <manish@zambeel.com>,
       "" <mingo@redhat.com>
Subject: Re: i7500 and IRQ assignment
In-Reply-To: <Pine.LNX.4.44.0211251615330.5004-100000@sp-laptop.isdn.scali.no>
Message-ID: <Pine.LNX.4.50.0211251042020.1462-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0211251615330.5004-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Nov 2002, Steffen Persvold wrote:

> 2.4.20-rc2 or -rc3 work fine on my E7500 boards. I've appiled the
> irqbalance patch from Ingo Molnar though. It gives me better interrupt
> latency compared to the APIC routing patch (with GbE it is ~10us faster on
> ping-pong/2 tests).

How does IRQ affinity fair with respect to your interrupt latencies?

	Zwane
-- 
function.linuxpower.ca

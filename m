Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267971AbTAMWkV>; Mon, 13 Jan 2003 17:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268392AbTAMWkU>; Mon, 13 Jan 2003 17:40:20 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:31576
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267971AbTAMWji>; Mon, 13 Jan 2003 17:39:38 -0500
Date: Mon, 13 Jan 2003 17:49:12 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jens Axboe <axboe@suse.de>
cc: Terje Eggestad <terje.eggestad@scali.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: any chance of 2.6.0-test*?
In-Reply-To: <20030113184831.GC14017@suse.de>
Message-ID: <Pine.LNX.4.44.0301131748010.2102-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, Jens Axboe wrote:

> > It uses NMI's to break into the debugger, so it would also work with 
> > interrupts disabled and spinning on a lock, the same is also true for 
> > kgdb.
> 
> But still requiring up-apic, or smp with apic, right?

Well UP with Local APIC will suffice. So that works on a lot of i686 
machines.

	Zwane
-- 
function.linuxpower.ca


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267124AbSKXCZG>; Sat, 23 Nov 2002 21:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbSKXCZG>; Sat, 23 Nov 2002 21:25:06 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:41538
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267124AbSKXCZG>; Sat, 23 Nov 2002 21:25:06 -0500
Date: Sat, 23 Nov 2002 21:35:54 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Ed Sweetman <ed.sweetman@wmich.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: cpufreq divide error in 2.5.49 
In-Reply-To: <3DE03845.4030406@wmich.edu>
Message-ID: <Pine.LNX.4.50.0211232135250.1462-100000@montezuma.mastecende.com>
References: <3DE03845.4030406@wmich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Nov 2002, Ed Sweetman wrote:

> 2.5.49 on an intel D850GB motherboard with acpi's on demand clock
> modulation for the P4 has a divide error: 0000 causing a kernel panic
> from attempting to kill init.
>
> It's completely repeatable and just finishes the PCI acpi irq routing
> when it happens on boot.  The cpu i'm using is a 1st gen P4 1.7Ghz,
> non-xeon.

Mind posting the oops? Or at least the stack trace and eip

	Zwane
-- 
function.linuxpower.ca

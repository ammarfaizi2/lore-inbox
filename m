Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSIXSWD>; Tue, 24 Sep 2002 14:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261747AbSIXSWC>; Tue, 24 Sep 2002 14:22:02 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:16391 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S261715AbSIXSV7>; Tue, 24 Sep 2002 14:21:59 -0400
Date: Tue, 24 Sep 2002 14:26:51 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mark Knecht <mknecht@controlnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP machines - IRQ Priorities
In-Reply-To: <000101c263eb$df8adfc0$b50aa8c0@mknecht>
Message-ID: <Pine.LNX.4.44.0209241409120.12397-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Mark Knecht wrote:

> Hi,
>    Excuse me for interrupting you guys too much. I hope you can find a
> minute to answer these two questions for me:
> 
> ***  When APIC IRQs are used (IRQs higher than 15) what is the IRQ serviced
> first? ***

Priority is done by vector (each irq is assigned a vector), you can see 
the listing at boot

	Zwane
-- 
function.linuxpower.ca


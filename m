Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261816AbSIXVHi>; Tue, 24 Sep 2002 17:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261818AbSIXVHh>; Tue, 24 Sep 2002 17:07:37 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:55304 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S261816AbSIXVHg>; Tue, 24 Sep 2002 17:07:36 -0400
Date: Tue, 24 Sep 2002 17:05:11 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: Ricky Beam <jfbeam@bluetronic.net>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: UP IO-APIC
In-Reply-To: <Pine.LNX.4.44.0209241359340.12397-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.3.96.1020924164343.19732A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Sep 2002, Zwane Mwaikambo wrote:

> 
> ... Or UP machines with chipsets with IOAPICs (Microsoft recommends 
> hardware manufaturers to use one).
> 
> > APIC support in 2.5 is very closely tied to SMP. (and technically, ACPI.)
> 
> Not the case for local APIC, i'll try building .38 with UP IOAPIC.

I didn't get a compile with it on, finally got a compile and boot of
2.5.38-mm2 with most of the patches here in the last few days. It doesn't
see my SCSI controller, sound doesn't work, but it booted ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262783AbSI2QAy>; Sun, 29 Sep 2002 12:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262786AbSI2QAy>; Sun, 29 Sep 2002 12:00:54 -0400
Received: from ns.commfireservices.com ([216.6.9.162]:55313 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id <S262783AbSI2QAx>; Sun, 29 Sep 2002 12:00:53 -0400
Date: Sun, 29 Sep 2002 12:04:52 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Murray J. Root" <murrayr@brain.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: v2.6 vs v3.0
In-Reply-To: <20020929111918.GA1639@Master.Wizards>
Message-ID: <Pine.LNX.4.44.0209291202000.24805-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 Sep 2002, Murray J. Root wrote:

> ASUS P4S533 (SiS645DX chipset)
> P4 2Ghz
> 1G PC2700 RAM
> 
> Disable SMP, enable APIC & IO APIC
> Get "WARNING - Unexpected IO APIC found"
> system freezes

Send the subsequent messages (iirc it prints some verbose info about the 
IOAPIC in question).

> Disable IO APIC, enable ACPI
> system detects ACPI, builds table, freezes.

Send messages, motherboard/chipset info..

> Disable ACPI, enable ide-scsi in the kernel
> kernel panic analyzing hdc

ditto.

> None of these have been reported because I haven't had time to do all the
> work involved in making a report that anyone on the team will read.

Shouldn't take too long, most time would be spent writing them down if you 
can't retrieve via serial console.

	Zwane
-- 
function.linuxpower.ca


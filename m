Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261721AbSJQRJt>; Thu, 17 Oct 2002 13:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261725AbSJQRJt>; Thu, 17 Oct 2002 13:09:49 -0400
Received: from s383.jpl.nasa.gov ([137.78.170.215]:971 "EHLO s383.jpl.nasa.gov")
	by vger.kernel.org with ESMTP id <S261721AbSJQRJr>;
	Thu, 17 Oct 2002 13:09:47 -0400
Date: Thu, 17 Oct 2002 10:15:26 -0700 (PDT)
From: Bryan B Whitehead <driver@huey.jpl.nasa.gov>
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Bryan Whitehead <driver@jpl.nasa.gov>, Mark Cuss <mcuss@cdlsystems.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
In-Reply-To: <Pine.LNX.3.95.1021017085043.5202A-100000@chaos.analogic.com>
Message-ID: <Pine.GSO.4.21.0210171012540.18710-100000@s383.jpl.nasa.gov>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Oct 2002, Richard B. Johnson wrote:

> On Wed, 16 Oct 2002, Bryan Whitehead wrote:
> 
> > My /proc/cpuinfo says I have ht CPU's... but i only see 2 CPU's... (Yet 
> > I have 2 1.7Ghz XEONs in the box so shouldn't I see 4?)
> > 
> > It's a Dell Precisions 530 workstation.
> > 
> > Does intel have ht CPU's that are messed up? and I'm one of the "lucky 
> > ones". ?
> > 
> > Building a kernel myself did not help... Any idea's?
> > 
> > pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
>                                                    ^____ hyperstuff
> 
> 
> Your CPU purports to "support" HT, but It doesn't "do" HT!
> Maybe somebody from Intel can explain, but I heard that they
> added the HT bit before they implimented hyper-threading.
> Anyways, maybe you can "turn something on" in the BIOS?
> If not, it's just one of those wanabees that didn't graduate
> from HT School.

FWIW, I don't have a HT option in my bios. i just updated the bios to the
latest version from Dell and still no option.

Maybe they put the wrong CPU's into my workstation that is classified to
not have HT XEON Cpus?

If that's the case, can I tweak something to ignore the bios and turn on
HT?

Anyway, I'm sure it's an Intel thing.... 1-bit never made me feel so
ripped off... ;)

> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
> The US military has given us many words, FUBAR, SNAFU, now ENRON.
> Yes, top management were graduates of West Point and Annapolis.
> 

--
Bryan Whitehead
SysAdmin - JPL - Interferometry Systems and Technology
Phone: 818 354 2903
driver@jpl.nasa.gov


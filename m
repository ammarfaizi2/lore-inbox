Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261698AbSJQMsy>; Thu, 17 Oct 2002 08:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbSJQMsx>; Thu, 17 Oct 2002 08:48:53 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2177 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S261698AbSJQMsu>; Thu, 17 Oct 2002 08:48:50 -0400
Date: Thu, 17 Oct 2002 08:56:15 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Bryan Whitehead <driver@jpl.nasa.gov>
cc: Mark Cuss <mcuss@cdlsystems.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel reports 4 CPUS instead of 2...
In-Reply-To: <3DADF488.1080204@jpl.nasa.gov>
Message-ID: <Pine.LNX.3.95.1021017085043.5202A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Oct 2002, Bryan Whitehead wrote:

> My /proc/cpuinfo says I have ht CPU's... but i only see 2 CPU's... (Yet 
> I have 2 1.7Ghz XEONs in the box so shouldn't I see 4?)
> 
> It's a Dell Precisions 530 workstation.
> 
> Does intel have ht CPU's that are messed up? and I'm one of the "lucky 
> ones". ?
> 
> Building a kernel myself did not help... Any idea's?
> 
> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
                                                   ^____ hyperstuff


Your CPU purports to "support" HT, but It doesn't "do" HT!
Maybe somebody from Intel can explain, but I heard that they
added the HT bit before they implimented hyper-threading.
Anyways, maybe you can "turn something on" in the BIOS?
If not, it's just one of those wanabees that didn't graduate
from HT School.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
The US military has given us many words, FUBAR, SNAFU, now ENRON.
Yes, top management were graduates of West Point and Annapolis.


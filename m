Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135322AbRA2K3Y>; Mon, 29 Jan 2001 05:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135568AbRA2K3P>; Mon, 29 Jan 2001 05:29:15 -0500
Received: from [24.67.108.36] ([24.67.108.36]:6528 "EHLO
	ogah.cgma1.ab.wave.home.com") by vger.kernel.org with ESMTP
	id <S135322AbRA2K3K>; Mon, 29 Jan 2001 05:29:10 -0500
Date: Mon, 29 Jan 2001 03:26:37 -0700
From: Harold Oga <ogah@home.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.1-pre11
Message-ID: <20010129032637.A642@ogah.cgma1.ab.wave.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10101281020540.3850-100000@penguin.transmeta.com> <E14NB8r-000063-00@roos.tartu-labor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14NB8r-000063-00@roos.tartu-labor>; from mroos@linux.ee on Mon, Jan 29, 2001 at 12:02:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 29, 2001 at 12:02:33PM +0200, Meelis Roos wrote:
>LT> I just uploaded it to kernel.org, and I expect that I'll do the final
>LT> 2.4.1 tomorrow, before leaving for NY and LinuxWorld. Please test that the
>LT> pre-kernel works for you..
>[...]
>LT> pre10:
>[...]
>LT>  - Andy Grover: APCI update
>
>I tried test11 yesterday. Works fine except when I enable ACPI instead of
>APM. Never tried this before but now I decided to give it a try.
>After initialising ACPI, the machine became slow as a 386 or a 286.
>
>AMD Duron 600, Soltek 75KV mobo w/VIA KT133 chipset, UP-APIC kernel, IDE-only
>system.
Hi,
   I'm seeing similar problems with my system on 2.4.1-pre10.  This is an
AMD Thunderbird 900, MSI K7T Pro2-A mobo w/VIA KT133 chipset, UP, ide/scsi
mix.  2.4.1-pre10 works fine if I don't configure ACPI.  I'll try to
narrow down when this problem started showing up later today, as I
initially moved from 2.4.1-pre3 straight to 2.4.1-pre10.

-Harold
-- 
"Life sucks, deal with it!"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

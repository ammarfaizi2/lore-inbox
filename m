Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S130003AbQK1JO2>; Tue, 28 Nov 2000 04:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131003AbQK1JOS>; Tue, 28 Nov 2000 04:14:18 -0500
Received: from dyn545.dhcp.lancs.ac.uk ([148.88.245.69]:12548 "EHLO
        dyn545.dhcp.lancs.ac.uk") by vger.kernel.org with ESMTP
        id <S130615AbQK1JOB>; Tue, 28 Nov 2000 04:14:01 -0500
Date: Tue, 28 Nov 2000 08:43:01 +0000 (GMT)
From: Stephen Torri <s.torri@lancaster.ac.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Dell 5000e APM (fixed!)
In-Reply-To: <E140YyV-0003pl-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0011280840590.3537-100000@dyn545.dhcp.lancs.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On the topic of APM, I have a supermicro P6DBE motherboard (SMP).
APM does not work because its not safe with SMP systems. What can I do to
get power management for this motherboard?

Stephen 

On Tue, 28 Nov 2000, Alan Cox wrote:

> > The BIOS listed is a new test BIOS that has a *corrected* APM that I
> > received this morning.  I really want to take a second to thank the
> 
> Good they've changed the BIOS id.
> 
> Thansk
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 

-- 
Buyer's Guide for a Operating System:
Don't care to know: Mac
Don't mind knowing but not too much: Windows
Hit me! I can take it!: Linux

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

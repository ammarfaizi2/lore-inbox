Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131477AbRDPM4n>; Mon, 16 Apr 2001 08:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131472AbRDPM43>; Mon, 16 Apr 2001 08:56:29 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:12553 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131477AbRDPM4N>; Mon, 16 Apr 2001 08:56:13 -0400
Subject: Re: Linux 2.4.3-ac7
To: clubneon@hereintown.net (Chris Meadors)
Date: Mon, 16 Apr 2001 13:57:34 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <Pine.LNX.4.31.0104160852560.16553-100000@rc.priv.hereintown.net> from "Chris Meadors" at Apr 16, 2001 08:56:44 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14p8ZV-0000C1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, 16 Apr 2001, Alan Cox wrote:
> > VIA users should test this kernel carefully. It has what are supposed to be
> > the right fixes for the VIA hardware bugs. Obviously the right fixes are not
> > as tested as the deduced ones.
> 
> I saw no mention of the ACPI idle problem I see on my Athlons.  Is the
> acpi=no-idle work around the perminate fix?

Ask Andrew Grover. I don't follow the ACPI threads. Having attempted to use
ACPI both on Linux and other OS's I've given up. Adding a bloated interpreter 
for an obscure, misdesigned bios hardware description language is simply not
my idea of progress. Its an extremely complicated way for intel to try and
keep stuff like speedstep proprietary, nothing more. 

APM works nicely on all my Athlons. 

Alan

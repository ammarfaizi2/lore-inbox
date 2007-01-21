Return-Path: <linux-kernel-owner+w=401wt.eu-S1751462AbXAUUDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbXAUUDg (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 15:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751481AbXAUUDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 15:03:36 -0500
Received: from vervifontaine.sonytel.be ([80.88.33.193]:46270 "EHLO
	vervifontaine.sonycom.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751462AbXAUUDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 15:03:35 -0500
Date: Sun, 21 Jan 2007 21:03:26 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: davids@webmaster.com,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: KB->KiB, MB -> MiB, ... (IEC 60027-2)
In-Reply-To: <45B3122C.20301@zytor.com>
Message-ID: <Pine.LNX.4.62.0701212101100.28541@pademelon.sonytel.be>
References: <MDEHLPKNGKAHNMBLJOLKEEKNBAAC.davids@webmaster.com>
 <45B3122C.20301@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2007, H. Peter Anvin wrote:
> David Schwartz wrote:
> > 	Talk about a cure worse than the disease! So you're saying that 256MB
> > flash
> > cards could be advertised as having 268.4MB? A 512MB RAM stick is
> > mislabelled and could correctly say 536.8MB? That's just plain craziness.
> > 
> > 	Adopting IEC 60027-2 just replaces a set of well-understood problems
> > with
> > all new problems.
> 
> Except that you're wrong above.  Most 512 MB flash cards are less than 512
> MiB; most of them are, in fact, around 512 MB!  RAM, of course, is
> consistently 512 MiB.
> 
> This little tidbit discovered in the process of working on an application
> which required powers-of-two flash cards, and finding that one does have to
> use one size larger...

Yeah, and Ethernet speed is measured in Mbps, not Mibps.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

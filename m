Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266171AbUAGKiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 05:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266173AbUAGKiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 05:38:21 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:10717 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S266171AbUAGKiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 05:38:19 -0500
X-Sender-Authentication: net64
Date: Wed, 7 Jan 2004 11:37:51 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Andreas Haumer <andreas@xss.co.at>
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: ACPI: problem on ASUS PR-DLS533
Message-Id: <20040107113751.1da9b288.skraw@ithnet.com>
In-Reply-To: <3FE85D67.1010707@xss.co.at>
References: <3FE82F4C.7070207@xss.co.at>
	<200312231448.03106.andrew@walrond.org>
	<3FE85D67.1010707@xss.co.at>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Dec 2003 16:21:11 +0100
Andreas Haumer <andreas@xss.co.at> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi!
> 
> Andrew Walrond wrote:
> > On Tuesday 23 Dec 2003 12:04 pm, Andreas Haumer wrote:
> >
> >>Hi!
> >>
> >>There are some ACPI-related problems w/ an ASUS PR-DLS5333
> >>Dual Xeon motherboard. I already reported this back in June
> >>for Linux-2.4.21-ac and since then I've tested several kernel
> >
> >
> > See http://bugme.osdl.org/show_bug.cgi?id=1662
> >
> > Len and co are working through the list, one bug at a time, so hopefully
> > they'll get to this soonish. I've also notified Asus about their bogus
> > bios, but little response so far :(
> >
> Thanks for the info. Your problem looks quite similar,
> but not completely identical. It's a different board,
> mine (the PR-DLS533) is the 533MHz FSB version of yours
> (the PR-DLS), I think.
> 
> Anyway, I'll try to add as much info as I can get
> to your bugzilla entry.

You are not alone ;-)

I have some TRL-DLS here (P-III). They have dual AIC onboard which are not
recognised under 2.4.24 but work flawlessly with ACPI in 2.4.23.

Regards,
Stephan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270929AbUJUUhK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270929AbUJUUhK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 16:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270936AbUJUUhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 16:37:07 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:26837 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S270947AbUJUUes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 16:34:48 -0400
Subject: Re: High pitched noise from laptop: processor.c in linux 2.6
From: Lee Revell <rlrevell@joe-job.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Cc: Pavel Machek <pavel@ucw.cz>, "Yu, Luming" <luming.yu@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <yw1xwtxl2tzo.fsf@mru.ath.cx>
References: <3ACA40606221794F80A5670F0AF15F8405D3BF5B@pdsmsx403>
	 <20041018114109.GC4400@openzaurus.ucw.cz> <yw1xekjt4fa8.fsf@mru.ath.cx>
	 <20041020154718.GD26439@elf.ucw.cz> <yw1x65554a7d.fsf@mru.ath.cx>
	 <1098291205.1429.76.camel@krustophenia.net>  <yw1xwtxl2tzo.fsf@mru.ath.cx>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1098390727.3705.24.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 21 Oct 2004 16:32:08 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 13:13, Måns Rullgård wrote:
> > I bet you could actually identify the singing capacitor using a
> > telephone toner wand.  IMHO this is a bad enough problem to RMA it. 
> 
> Not really, it's barely noticeable in a quiet room.

If you had bought that laptop for audio use (big market these days, just
look at all the FireWire/USB/PCMCIA sound hardware out there), then this
would be a fatal problem.

Of course, for such a user, a BIOS where the hardware constantly block
interrupts via SMM would also be a fatal problem because it ruins audio
latency.  According to Alan Cox this is most laptops these days!

I am beginning to suspect the only known good laptop for pro audio use
is a Powerbook :-/.  x86 laptops are just too cheaply made.

Lee


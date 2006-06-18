Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWFRCld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWFRCld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 22:41:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbWFRCld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 22:41:33 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:44635 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932071AbWFRCld (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 22:41:33 -0400
Date: Sat, 17 Jun 2006 19:41:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: ck@vds.kolivas.org, Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       ocilent1@gmail.com, linux list <linux-kernel@vger.kernel.org>
Subject: Re: sound skips on 2.6.16.17
Message-ID: <20060618024130.GA32399@tuatara.stupidest.org>
References: <4487F942.3030601@att.net.mx> <200606161115.53716.ocilent1@gmail.com> <4493D24D.2010902@att.net.mx> <200606172129.56986.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606172129.56986.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2006 at 09:29:56PM +1000, Con Kolivas wrote:

> > > 1)  PCI-VIA-quirk-fixup-additional-PCI-IDs.patch

that shouldn't break things, if it does I *really* want to know

> > > 2)
> PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch

nor should that, so again i would like to know if this is the one that
makes a difference

> > Works like a charm. End of the sound skips.

what cpu/mainboard/etc

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932085AbWFREkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWFREkv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 00:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWFREku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 00:40:50 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:57954 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932085AbWFREku (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 00:40:50 -0400
Date: Sat, 17 Jun 2006 21:40:47 -0700
From: Chris Wedgwood <cw@f00f.org>
To: ocilent1 <ocilent1@gmail.com>
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
Subject: Re: sound skips on 2.6.16.17
Message-ID: <20060618044047.GA1261@tuatara.stupidest.org>
References: <4487F942.3030601@att.net.mx> <200606172129.56986.kernel@kolivas.org> <20060618024130.GA32399@tuatara.stupidest.org> <200606181204.29626.ocilent1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606181204.29626.ocilent1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 18, 2006 at 12:04:29PM +0800, ocilent1 wrote:

> (PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch)
> that is causing the sound stuttering/skipping problems for our users
> with VIA chipsets. Backing out the first patch alone did not fix the
> problem (PCI-VIA-quirk-fixup-additional-PCI-IDs.patch) but to back
> out the 2nd patch, you need to have initially backed out the first
> patch, due to the way the patches apply in series.

what mainboard/CPU do you have there?

what does 'lspci -n' say?

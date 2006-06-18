Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932090AbWFREtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932090AbWFREtv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 00:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWFREtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 00:49:50 -0400
Received: from smtp3.adl2.internode.on.net ([203.16.214.203]:13841 "EHLO
	smtp3.adl2.internode.on.net") by vger.kernel.org with ESMTP
	id S932090AbWFREtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 00:49:50 -0400
From: ocilent1 <ocilent1@gmail.com>
Reply-To: ocilent1@gmail.com
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: sound skips on 2.6.16.17
Date: Sun, 18 Jun 2006 12:49:34 +0800
User-Agent: KMail/1.9.1
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org,
       Hugo Vanwoerkom <rociobarroso@att.net.mx>,
       linux list <linux-kernel@vger.kernel.org>
References: <4487F942.3030601@att.net.mx> <200606181204.29626.ocilent1@gmail.com> <20060618044047.GA1261@tuatara.stupidest.org>
In-Reply-To: <20060618044047.GA1261@tuatara.stupidest.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606181249.35367.ocilent1@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 18 June 2006 12:40, Chris Wedgwood wrote:
> On Sun, Jun 18, 2006 at 12:04:29PM +0800, ocilent1 wrote:
> > (PCI-quirk-VIA-IRQ-fixup-should-only-run-for-VIA-southbridges.patch)
> > that is causing the sound stuttering/skipping problems for our users
> > with VIA chipsets. Backing out the first patch alone did not fix the
> > problem (PCI-VIA-quirk-fixup-additional-PCI-IDs.patch) but to back
> > out the 2nd patch, you need to have initially backed out the first
> > patch, due to the way the patches apply in series.
>
> what mainboard/CPU do you have there?
>
> what does 'lspci -n' say?

I personally don't have any via mb's.... I just package the kernels... I will 
try and get some more detailed info from my testers for you.... 
-- 
*ocilent1

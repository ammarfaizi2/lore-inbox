Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWAIOc6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWAIOc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 09:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932294AbWAIOc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 09:32:57 -0500
Received: from ns.firmix.at ([62.141.48.66]:51424 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932287AbWAIOc5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 09:32:57 -0500
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux
	can't for a long time
From: Bernd Petrovitsch <bernd@firmix.at>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <200601091403.46304.yarick@it-territory.ru>
References: <174467f50601082354y7ca871c7k@mail.gmail.com>
	 <200601091207.14939.yarick@it-territory.ru>
	 <200601091022.30758.s0348365@sms.ed.ac.uk>
	 <200601091403.46304.yarick@it-territory.ru>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 09 Jan 2006 15:32:39 +0100
Message-Id: <1136817159.5785.47.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-01-09 at 14:03 +0300, Yaroslav Rastrigin wrote:
> Hi, 
> > > > money to the right people.
> > >
> > > Could or would you be so kind to provide at least moderately complete
> > > pricelist ? Whom and how much should I pay to have correct support for
> > > intel graphics chipset, 2200BG Wi-Fi, complete
> > > suspend-to-disk/suspend-to-ram and to get an overall performance boost ?
> > 
> > Since these are all supported in 2.6.15, $0 would be my quote.
> I've mentioned _correct_ support. Contrary to current rather sad state of things. 
> 855GM still has no support for non-VESA videomodes (1280x800 can be enabled only via VBIOS hacks, and is not always properly restored on resume) 
> (and don't supported with intelfb) (which, AFAIK, has no support for dualhead)
> 2200BG sometimes starts to unacceptably lag and drop packets after going out of suspend (either STR or STD) and until reboot.
> (And this is driver issue)
> Suspend to ram works, more or less, but drains power like hungry cat drinks milk, and I just can't leave my laptop in STR for more than two days 
> without worrying about my on-the-road availability. 
> Suspend to disk has nasty tendency to ruin my whole hot live X session, since X can't properly restore VT on resume.
> Overall performance isn't that bad, either, but I just can't understand, why KATE (Kde more or less advanced editor) takes twice as long to start 
> as UltraEdit in _emulated_ (VMWare) Windows XP running on this same box.
> 
> So, the question remains the same - whom and how much I need to pay to solve abovementioned problems ?

The best place to ask this question is IMHO the respective development
lists and/or maintainers. If both of this does not exist, find recent
patch submitters (who provided patches for more than whitespace and
similar cleanups) and ask them.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services


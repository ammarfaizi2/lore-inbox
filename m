Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWAKMl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWAKMl7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 07:41:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbWAKMlc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 07:41:32 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:32773 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751339AbWAKMla
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 07:41:30 -0500
Date: Tue, 10 Jan 2006 12:00:40 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Yaroslav Rastrigin <yarick@it-territory.ru>
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>, andersen@codepoet.org,
       linux-kernel@vger.kernel.org
Subject: Re: Why the DOS has many ntfs read and write driver,but the linux can't for a long time
Message-ID: <20060110120039.GA2814@ucw.cz>
References: <174467f50601082354y7ca871c7k@mail.gmail.com> <200601091207.14939.yarick@it-territory.ru> <200601091022.30758.s0348365@sms.ed.ac.uk> <200601091403.46304.yarick@it-territory.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601091403.46304.yarick@it-territory.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

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

Buy SLES with support contract. We should be able to help with
s-t-disk and ipw2200... 2 days in s-t-ram sounds quite ok, why
do you think anytink is wrong there?
						Pavel
-- 
Thanks, Sharp!

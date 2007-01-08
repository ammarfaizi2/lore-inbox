Return-Path: <linux-kernel-owner+w=401wt.eu-S1750816AbXAHXgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbXAHXgb (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 18:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750804AbXAHXgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 18:36:31 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:44136 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXAHXga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 18:36:30 -0500
Date: Tue, 9 Jan 2007 00:30:06 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tim Pepper <tpepper@gmail.com>
cc: Pavel Machek <pavel@ucw.cz>, Alan <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>, Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
In-Reply-To: <eada2a070701081417s3d3d0b3es655211335c00b4e4@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0701090029260.20773@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org> 
 <Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr> 
 <20070107114439.GC21613@flint.arm.linux.org.uk>  <45A0F060.9090207@imap.cc>
  <1168182838.14763.24.camel@shinybook.infradead.org> 
 <20070107153833.GA21133@flint.arm.linux.org.uk>  <20070107182151.7cc544f3@localhost.localdomain>
  <Pine.LNX.4.61.0701072011510.4365@yvahk01.tjqt.qr> 
 <20070107223055.1dc7de54@localhost.localdomain>  <20070108161425.GA2208@elf.ucw.cz>
 <eada2a070701081417s3d3d0b3es655211335c00b4e4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 8 2007 14:17, Tim Pepper wrote:
> On 1/8/07, Pavel Machek <pavel@ucw.cz> wrote:
>> On Sun 2007-01-07 22:30:55, Alan wrote:
>> > I think that would be a good idea - and add it to the coding/docs
>> > specs
>> > that documentation is UTF-8. Code should IMHO say 7bit though.
>> 
>> Yes, yes, please.
>> 
>> I have been flamed when someone tried to do 8bit patch, and I was
>> trying to NAK it...
>
> Could this get put in Documentation/CodingStyle?

Someone do that.

> And an item added to
> the kernel janitors' list to fix up 8bit files?  Last I looked trying

That's already been just done by me. http://lkml.org/lkml/2007/1/8/222

> to decided if there was a standard here I found a mish-mash of
> encodings based output of file vs Linus' git tree.

	-`J'
-- 

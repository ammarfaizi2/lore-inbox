Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264331AbTKZWhP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 17:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264353AbTKZWhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 17:37:15 -0500
Received: from web40911.mail.yahoo.com ([66.218.78.208]:30519 "HELO
	web40911.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264331AbTKZWhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 17:37:10 -0500
Message-ID: <20031126223709.37332.qmail@web40911.mail.yahoo.com>
Date: Wed, 26 Nov 2003 14:37:09 -0800 (PST)
From: Bradley Chapman <kakadu_croc@yahoo.com>
Subject: Re: Beaver In Detox AND IEEE1394 badness message
To: Ben Collins <bcollins@debian.org>
Cc: linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20031126222052.GA462@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mr. Collins,

--- Ben Collins <bcollins@debian.org> wrote:
> > blk: queue dfd658cc, I/O limit 4095Mb (mask 0xffffffff)
> > 
> > The badness message appears AFTER this line:
> > 
> > ohci1394_0: OHCI-1394 1.1 (PCI): IRQ=[10]  MMIO=[e8207000-e82077ff]  Max
> > Packet=[2048]
> > 
> > It used to appear BEFORE this line. Do the IEEE1394 fixes in the detoxed beaver
> > kernel have something to do with that? Or was it a fix in an earlier kernel?
> 
> Odd, I fixed one, and another one pops up. Sucks that it doesn't show up
> for me, but thanks for the traceback.

You're welcome.

> 
> Do things operate normally for you? Disabling kernel debug will kill the
> message (the symptom, not the problem). With the fixes I sent Linus, I
> am mainly interested in it just working.

Unfortunately, this is only an academic exercise -- I don't actually have any
IEEE1394 devices to test this driver with! *blushes*

However, a bug is a bug is a bug, so I reported it anyway. If it's absolutely
necessary, I think I can get my hands on some IEEE1394 stuff from a few people
I know and test it with that.

Brad


=====


__________________________________
Do you Yahoo!?
Free Pop-Up Blocker - Get it now
http://companion.yahoo.com/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267855AbRGUXy7>; Sat, 21 Jul 2001 19:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267860AbRGUXyu>; Sat, 21 Jul 2001 19:54:50 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:62474
	"EHLO Opus.bloom.county") by vger.kernel.org with ESMTP
	id <S267855AbRGUXyd>; Sat, 21 Jul 2001 19:54:33 -0400
Date: Sat, 21 Jul 2001 16:53:46 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: "peter k." <spam-goes-to-dev-null@gmx.net>, linux-kernel@vger.kernel.org
Subject: [OT] Re: 2.4.7: wtf is "ksoftirqd_CPU0"
Message-ID: <20010721165346.U3889@opus.bloom.county>
In-Reply-To: <000f01c111ff$73602ce0$c20e9c3e@host1> <3B59AFF7.8061645B@mandrakesoft.com> <01072201370202.02679@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01072201370202.02679@starship>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, Jul 22, 2001 at 01:37:02AM +0200, Daniel Phillips wrote:
> On Saturday 21 July 2001 18:38, Jeff Garzik wrote:
> > "peter k." wrote:
> > > i just installed 2.4.7, now a new process called "ksoftirqd_CPU0"
> > > is started automatically when booting (by the kernel obviously)?
> > > why? what does it do? i didnt find any useful information on it in
> > > linuxdoc / linux-kernel archives
> >
> > it is used internally, ignore it.
> 
> It's pretty hard to ignore a process with a name that ugly ;-)
> 
> How about just ksoft0 ?  Or kirq0?

Now this is just getting silly.  It follows the same convention the
6-8 other k* daemons follow.  Would you want kswpd? kupd? kreclmd?  Probably
not.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

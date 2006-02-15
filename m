Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945972AbWBOPOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945972AbWBOPOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 10:14:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945973AbWBOPOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 10:14:01 -0500
Received: from solarneutrino.net ([66.199.224.43]:15625 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1945972AbWBOPOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 10:14:00 -0500
Date: Wed, 15 Feb 2006 10:13:56 -0500
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Jean Delvare <khali@linux-fr.org>, Erik Mouw <erik@harddisk-recovery.com>,
       Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
Subject: Re: Random reboots
Message-ID: <20060215151356.GA17864@tau.solarneutrino.net>
References: <20060213210435.GC16566@tau.solarneutrino.net> <20060213211044.066CE5E401E@latitude.mynet.no-ip.org> <20060213212243.GE16566@tau.solarneutrino.net> <7c3341450602131332x2fcd7d8co@mail.gmail.com> <20060213213929.GG16566@tau.solarneutrino.net> <20060214132904.GI16566@tau.solarneutrino.net> <20060214232222.5d4384a8.khali@linux-fr.org> <20060215142809.GA17842@tau.solarneutrino.net> <Pine.LNX.4.61.0602151003480.4854@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0602151003480.4854@chaos.analogic.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 10:11:45AM -0500, linux-os (Dick Johnson) wrote:
> > The sensors report a bunch of obvious nonsesne as always...  I keep them
>                                 ^^^^^^^^^^^^^^^^^^^_________ Hint?
> 
> I have a "new" machine with a "Thunder" board. It started to re-boot
> for no good reason at all. It turns out that the plastic catch in
> the fan/heatsink hold-down mechanism broke so the heatsink was
> not tight against the CPU. I "fixed" it by tying it down with
> some wire. The reboot problems, and some other "strange" problems
> went away. One of the strange problems was that my 'C' runtime
> library got corrupted, as well as some other read-only files,
> even though e3fsck never found any problems.

All the temps have always reported 77C.  I felt the heatsinks this
morning, and they're fine.

-ryan

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVBMIWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVBMIWQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 03:22:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBMIWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 03:22:16 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:36771 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S261253AbVBMIWN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 03:22:13 -0500
Date: Sun, 13 Feb 2005 09:22:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Lee Revell <rlrevell@joe-job.com>,
       Andries Brouwer <aebr@win.tue.nl>, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: i8042 access timings
Message-ID: <20050213082246.GC1535@ucw.cz>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com> <20050125194647.GB3494@pclin040.win.tue.nl> <1106685456.10845.40.camel@krustophenia.net> <1106838875.14782.20.camel@localhost.localdomain> <20050127163431.GA31212@ti64.telemetry-investments.com> <20050127163714.GA15327@ucw.cz> <20050213001659.GA7349@ti64.telemetry-investments.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050213001659.GA7349@ti64.telemetry-investments.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 12, 2005 at 07:16:59PM -0500, Bill Rugolsky Jr. wrote:

> Sorry for the long delay in replying; the HiNote needed some effort to get
> the thing up and running again.  [Various bits of hardware are broken;
> the power switch, floppy, and CD-ROM are busted/flakey.]  I've now got
> Fedora Core 3 running on it. I was pleasantly surprised that the 2.6.9
> i83265 PCMCIA module loads, and the internal Xircom CEM56 network/modem works.
> [Broken with 2.6.10+ though; the fix is probably trivial.]
> 
> I wasn't sure exactly what to test.  I applied the following patch
> to 2.6.11-rc3-bk9, and booted with i8042_debug=1.  So far, it works
> as expected, and there is nothing of interest in the kernel log.
> [Also worked with the FC3 2.6.9 kernel and this patch+DEBUG.]
> 
> Now that things are up and running, I will apply any patches that you
> would like tested.

And I suppose it was running just fine without the patch as well?

The question was whether the patch helps, or whether it is not needed.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

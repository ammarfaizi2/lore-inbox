Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVA0Qeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVA0Qeg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 11:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbVA0Qeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 11:34:36 -0500
Received: from 209-166-240-202.cust.walrus.com ([209.166.240.202]:653 "EHLO
	ti41.telemetry-investments.com") by vger.kernel.org with ESMTP
	id S262655AbVA0Qeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 11:34:31 -0500
Date: Thu, 27 Jan 2005 11:34:31 -0500
From: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Andries Brouwer <aebr@win.tue.nl>,
       dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: i8042 access timings
Message-ID: <20050127163431.GA31212@ti64.telemetry-investments.com>
Mail-Followup-To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Lee Revell <rlrevell@joe-job.com>, Andries Brouwer <aebr@win.tue.nl>,
	dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Vojtech Pavlik <vojtech@suse.cz>
References: <200501250241.14695.dtor_core@ameritech.net> <20050125105139.GA3494@pclin040.win.tue.nl> <d120d5000501251117120a738a@mail.gmail.com> <20050125194647.GB3494@pclin040.win.tue.nl> <1106685456.10845.40.camel@krustophenia.net> <1106838875.14782.20.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106838875.14782.20.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2005 at 03:14:36PM +0000, Alan Cox wrote:
> Myths are not really involved here. The IBM PC hardware specifications
> are fairly well defined and the various bits of "we glued a 2Mhz part
> onto the bus" stuff is all well documented. Nowdays its more complex
> because most kbc's aren't standalone low end microcontrollers but are
> chipset integrated cells or even software SMM emulations.
> 
> The real test is to fish out something like an old Digital Hi-note
> laptop or an early 486 board with seperate kbc and try it.
 
I have a Digital HiNote collecting dust which had this keyboard problem
with the RH 6.x 2.2.x boot disk kernels, IIRC.  I can test if you like,
but I won't be able to get to it until the weekend.

	Bill Rugolsky

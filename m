Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbUJaPr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbUJaPr3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 10:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUJaPr2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 10:47:28 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:24496 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261171AbUJaPr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 10:47:26 -0500
Subject: Re: [OT] Re: code bloat [was Re: Semaphore assembly-code bug]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: Lee Revell <rlrevell@joe-job.com>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Tim Hockin <thockin@hockin.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410310155080.11293@ppg_penguin.kenmoffat.uklinux.net>
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>
	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>
	 <20041030222720.GA22753@hockin.org>
	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua>
	 <1099178405.1441.7.camel@krustophenia.net>
	 <1099176751.25194.12.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0410310155080.11293@ppg_penguin.kenmoffat.uklinux.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1099233850.16420.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 31 Oct 2004 14:44:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-10-31 at 01:09, Ken Moffat wrote:
> and the time to load it is irrelevant.  Since then I've had an anecdotal
> report that -Os is known to cause problems with gnome.  I s'pose people
> will say it serves me right for doing my initial testing on ppc which
> didn't have this problem ;)  The point is that -Os is *much* less tested
> than -O2 at the moment.

I've seen no real problems - x86-32 or x86-64, and my gnumeric appears
happy. Could be that the Red Hat gcc 3.3 has the relevant fixes already
in it from upstream I guess.


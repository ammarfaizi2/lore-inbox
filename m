Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289211AbSBDWRp>; Mon, 4 Feb 2002 17:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289212AbSBDWRf>; Mon, 4 Feb 2002 17:17:35 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:18180 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289211AbSBDWR0>; Mon, 4 Feb 2002 17:17:26 -0500
Date: Mon, 4 Feb 2002 17:16:27 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
In-Reply-To: <20020201100303.A14415@sistina.com>
Message-ID: <Pine.LNX.3.96.1020204171446.31056B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Feb 2002, Heinz J . Mauelshagen wrote:

> The LVM2 sofware no longer uses a particular driver which is just
> usable for its own purpose.
> It rather accesses a different, so-called 'device-mapper' driver, which
> implements a generic volume management service for the Linux kernel by
> supporting arbitray mappings of address ranges to underlying block devices.
> Because this is a generic service rather than an application within the kernel,
> it is open to be used by multiple LVM implementations (for eg. EVMS could be
> ported to use it :-)

Interesting concept, but something like the "smitZ" interface to RAID and
sizing would be really nice to reduce training effort. Since IBM is
pushing Linux, take this as a HINT.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129498AbRCHSvz>; Thu, 8 Mar 2001 13:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129495AbRCHSvp>; Thu, 8 Mar 2001 13:51:45 -0500
Received: from kerberos.suse.cz ([195.47.106.10]:61703 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129491AbRCHSvh>;
	Thu, 8 Mar 2001 13:51:37 -0500
Date: Thu, 8 Mar 2001 19:51:07 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12 (vt82c686 info)
Message-ID: <20010308195107.A8509@suse.cz>
In-Reply-To: <20010307201437.A5030@suse.cz> <Pine.LNX.3.95.1010307131509.31180A-100000@scsoftware.sc-software.com> <Pine.LNX.3.95.1010307131509.31180A-100000@scsoftware.sc-software.com> <20010308091706.B799@suse.cz> <200103081730.f28HUNi00929@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103081730.f28HUNi00929@adsl-209-76-109-63.dsl.snfc21.pacbell.net>; from whitney@math.berkeley.edu on Thu, Mar 08, 2001 at 09:30:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2001 at 09:30:23AM -0800, Wayne Whitney wrote:

> In mailing-lists.linux-kernel, you wrote:
> 
> > Make sure you use the latest 2.4.2-acxx drivers. Most other versions of
> > my drivers have little bugs in the 686b support. Harmless but somewhat
> > annoying.
> 
> Does this mean that the version 3.21 of your driver in the latest
> 2.4.2-acxx is newer than the version 4.3 that you distributed to the
> LKML a couple weeks ago?

They're about the same - only Alan didn't like the PCI speed measurement
code that's new in the 4.x series, so I added all the other changes to
the 3.20 driver, and 3.21 was born.

4.x is development
3.x is stable

-- 
Vojtech Pavlik
SuSE Labs

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751747AbWB1Bw4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751747AbWB1Bw4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:52:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWB1Bw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:52:56 -0500
Received: from main.gmane.org ([80.91.229.2]:1232 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750724AbWB1Bwz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:52:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jason Lunz <lunz@falooley.org>
Subject: Re: [RFC] Add kernel<->userspace ABI stability documentation
Date: Tue, 28 Feb 2006 01:52:40 +0000 (UTC)
Organization: PBR Streetgang
Message-ID: <du0ad8$hml$1@sea.gmane.org>
References: <20060227190150.GA9121@kroah.com> <20060227193654.GA12788@kvack.org> <20060227194623.GC9991@suse.de> <Pine.LNX.4.64.0602271216340.22647@g5.osdl.org> <20060227234525.GA21694@suse.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-065-013-029-145.sip.asm.bellsouth.net
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

greg@kroah.com said:
> Ok, I don't mind the name change from something different than
> "private".  I was looking for something to call the interface between
> the user and kernel that almost all userspace programs should be using
> the library instead of the "raw" kernel interface.  ALSA and netlink are
> two examples of this, and I'm sure there's others.

well, what about calling it "raw" then?

Jason


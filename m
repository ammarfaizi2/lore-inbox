Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264384AbUFINYs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264384AbUFINYs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 09:24:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265789AbUFINXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 09:23:18 -0400
Received: from mailman2.ppco.com ([138.32.33.140]:3465 "EHLO mailman2.ppco.com")
	by vger.kernel.org with ESMTP id S265776AbUFINM2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 09:12:28 -0400
From: Norman Weathers <norman.r.weathers@conocophillips.com>
Reply-To: norman.r.weathers@conocophillips.com
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: 2.4.26 SMP lockup problem
Date: Wed, 9 Jun 2004 08:12:20 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0406082058400.24569-100000@coffee.psychology.mcmaster.ca>
In-Reply-To: <Pine.LNX.4.44.0406082058400.24569-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406090812.20041.norman.r.weathers@conocophillips.com>
X-OriginalArrivalTime: 09 Jun 2004 13:12:21.0918 (UTC) FILETIME=[663AFBE0:01C44E23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Tuesday 08 June 2004 08:00 pm, Mark Hahn wrote:
> > CONFIG_X86_LOCAL_APIC=y
>
> that's the first thing I'd try turning off...
>

I have it disabled on the lilo promptwith noapic.  If that is not enough to 
keep it disabled on these nodes, then I will turn it off completely.

> > make), great as I have about 200 nodes right now that are candidates for
> > testing.
>
> heh.  I'm a cluster admin myself, much smaller now, but looking
> at adding 512-768 duals by the end of the year.  gulp!

Just went through that with a series of IBM blades.  Don't envy ya.

-- 

Norman Weathers
SIP Linux Cluster
TCE UNIX
ConocoPhillips
Houston, TX

Office:  LO2003
Phone:   ETN  639-2727
	 or (281) 293-2727

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbTE0Pj7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263925AbTE0Pj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:39:59 -0400
Received: from holomorphy.com ([66.224.33.161]:46310 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263922AbTE0Pj4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:39:56 -0400
Date: Tue, 27 May 2003 08:52:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: John Stoffel <stoffel@lucent.com>
Cc: DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <20030527155259.GK8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	John Stoffel <stoffel@lucent.com>,
	DevilKin-LKML <devilkin-lkml@blindguardian.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16083.35048.737099.575241@gargle.gargle.HOWL>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 27, 2003 at 11:48:56AM -0400, John Stoffel wrote:
>   Subarchitecture Type (PC-compatible, Voyager (NCR), NUMAQ (IBM/Sequent), Summit/EXA (IBM x440), Support for other sub-arch SMP systems with more than 8 CPUs, SGI 320/540 (Visual Workstation), Generic architecture (Summit, bigsmp, default)) [PC-compatible] (NEW) 
> What the hell am I supposed to enter here?  This is just friggin ugly
> and un-readable.  It should be cleaned up.  Or is it just that the
> help entry is appended to the question improperly here?  That's sorta
> what it looks like peering at it with my head turned to the left all
> the way.

If you don't know, then just hit "enter".


On Tue, May 27, 2003 at 11:48:56AM -0400, John Stoffel wrote:
> Are these choices all mutually exclusive?  Or can you build a kernel
> which will run on all these machines?  Now that would be interesting
> for a distro to have... not.  *grin*

Yes, they're mutually exclusive. You can't build one that will run on
all those machines because the programming isn't done right for that.
But the generic architecture option will run on at least 3.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTE1DID (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 23:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264489AbTE1DIC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 23:08:02 -0400
Received: from franka.aracnet.com ([216.99.193.44]:54746 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264487AbTE1DIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 23:08:00 -0400
Date: Tue, 27 May 2003 20:20:48 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Roman Zippel <zippel@linux-m68k.org>, John Stoffel <stoffel@lucent.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       DevilKin-LKML <devilkin-lkml@blindguardian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.70 compile error
Message-ID: <9880000.1054092047@[10.10.2.4]>
In-Reply-To: <20030527234051.GA7174@suse.de>
References: <Pine.LNX.4.44.0305261903330.2164-100000@home.transmeta.com> <200305271048.36495.devilkin-lkml@blindguardian.org> <20030527130515.GH8978@holomorphy.com> <200305271729.49047.devilkin-lkml@blindguardian.org> <20030527153619.GJ8978@holomorphy.com> <16083.35048.737099.575241@gargle.gargle.HOWL> <Pine.LNX.4.44.0305272010550.12110-100000@serv> <20030527184016.GA5847@suse.de> <4060000.1054072761@[10.10.2.4]> <20030527234051.GA7174@suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > Please, not more layered config options! That just makes people who
>  > want to enable the x440 or other alternative platform require fair
>  > amounts of psychic power (maybe this can be fixed with a big fat help
>  > message, but so can the current method).
> 
> With all due respect, 'screw x440 et al'. The fact remains that a
> majority of users won't even know what an x440 _is_, let alone
> need to configure for one.  If someone has actually ended up with
> one of those, I'd like to think they at least have enough clue to
> know what it is they've just spent their megabucks on.		

;-)
 
>  > If you're going hide the other options away so much, then the default
>  > should be the generic arch, IMHO.
> 
> That's precisely what I was saying.  I think we're in agreement,
> in a roundabout 'same but different' sort of way. I think.

OK, I think so ... I just think making the generic arch the default is
sufficient, without hiding things away under another menu where it's
harder to find ... if people don't understand the question, they should
just take the default. Frigging with the wording might help a bit ...
I think there's some way to force a hint to appear automatically like 
"if you don't know, use XXX".

M.


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263310AbTLJIqC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 03:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTLJIqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 03:46:02 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57260 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263310AbTLJIqA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 03:46:00 -0500
Date: Wed, 10 Dec 2003 09:45:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <thornber@sistina.com>
Cc: Paul Jakma <paul@clubi.ie>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031210084546.GG3988@suse.de>
References: <20031209134551.GG472@reti> <Pine.LNX.4.44.0312091206490.1289-100000@logos.cnet> <20031209143412.GI472@reti> <Pine.LNX.4.56.0312092106280.30298@fogarty.jakma.org> <20031209222624.GA6591@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209222624.GA6591@reti>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09 2003, Joe Thornber wrote:
> On Tue, Dec 09, 2003 at 09:07:49PM +0000, Paul Jakma wrote:
> > On Tue, 9 Dec 2003, Joe Thornber wrote:
> > Would this be of any aid to 2.4 users to transition to DM, so that
> > they can then easily test 2.6 and boot back to 2.4 if needs be?
> > 
> > If so, my vote would be for it to be included in 2.4.
> 
> yes

Seems to me, it's the lvm2 teams responsibility to provide easy
transition to 2.6 from 2.4. Merging dm in 2.4 right now looks like a
step in the wrong direction.

Arguments akin to "But XFS got merged, surely we can to" don't hold up
one bit. Should be obvious why.

-- 
Jens Axboe


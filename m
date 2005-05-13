Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVEMS0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVEMS0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVEMS0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:26:52 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:31204 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S262468AbVEMS0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:26:50 -0400
Date: Fri, 13 May 2005 14:26:50 -0400
To: "Michael H. Warfield" <mhw@wittsend.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Sync option destroys flash!
Message-ID: <20050513182650.GJ23488@csclub.uwaterloo.ca>
References: <1116001207.5239.38.camel@localhost.localdomain> <20050513171758.GB23621@csclub.uwaterloo.ca> <1116006828.5239.72.camel@localhost.localdomain> <20050513180915.GH23488@csclub.uwaterloo.ca> <1116008483.5239.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116008483.5239.79.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2005 at 02:21:23PM -0400, Michael H. Warfield wrote:
> 	Funny you should mention SanDisk.  Maybe the newer ones have gotten
> better but the CF cards I used in my PDA were mixes of the SanDisk 128
> Meg and SimpleTech 128 Meg.  Burned up several before I realized it was
> the nightly backup program that was eating them and I didn't notice any
> difference between the brands.  I don't know what controller was in the
> SimpleTech CF cards.  Any way to tell short of dismantling them?

Not really.  I believe sandisk has wear leveling on the 201 series CF
cards and on their new generation CF/SD for sure they have it (and
unfortunately for us they discontinued industrial temperature in the new
line so we have had to look elsewhere for CF cards).

Unfortunately a lot of what is sold to consumers at retail is cheap
crap. :)

Len Sorensen

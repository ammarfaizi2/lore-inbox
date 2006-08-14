Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbWHNPUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbWHNPUD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 11:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750836AbWHNPUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 11:20:02 -0400
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:30602 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S1750729AbWHNPUB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 11:20:01 -0400
Date: Mon, 14 Aug 2006 17:20:00 +0200
From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Touchpad problems with latest kernels
Message-ID: <20060814152000.GA19065@rhlx01.fht-esslingen.de>
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl> <200608141038.04746.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200608141038.04746.gene.heskett@verizon.net>
User-Agent: Mutt/1.4.2.1i
X-Priority: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2006 at 10:38:04AM -0400, Gene Heskett wrote:
> I don't *think* I'm a lunatic, but I'm equally sure that the synaptics is a 
> pain in the ass and should be capable of being totally disabled somehow, 
> hopefully short of opening the lappy up and unplugging or cutting every 
> lead to it until such time as it can be made to behave instead of 
> responding to every thumb waved 1/2 to 3/4" above it.  I've gotten hand 
> cramps trying to hold my thumbs far enough away from that abomination to 
> stop such goings on.
> 
> So count this as a vote FOR doing something about the synaptics touchpad 
> situation.

I'm seeing issues as well on my Dell Inspiron 8000 (yes, it has a Synaptics,
NOT ALPS as usual on Inspiron):

(without a mouse plugged in) after random times the pointer exhibits
clear signs of craziness, moving on its own (mild issue) or jumping
uncontrollably (worse) or being completely off-screen most of the time
(worst).

IIRC (I'm quite sure about this) the very first time that I've seen
this phenomenon happen on my notebook was around 2.6.9,
and I attributed this to broken/grown-old hardware on my notebook
(thus from then on mostly running with external mouse attached),
but since several people now report very similar issues
one would think that it's a driver calibration or touchpad setup issue
instead of actually broken touchpad hardware.

Plus, I'm sometimes having issues with pointer movement (cursor won't advance
any more unless I stop touching the touchpad for a few seconds to let it
reset somehow - probably a bytestream hickup issue).

Any clues?

Andreas Mohr

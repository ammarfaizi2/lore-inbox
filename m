Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264406AbTKUR5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 12:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbTKUR5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 12:57:14 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:21386 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264406AbTKUR5K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 12:57:10 -0500
Date: Fri, 21 Nov 2003 18:50:25 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: jt@hpl.hp.com
Cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@pobox.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
Message-ID: <20031121175025.GB22734@ucw.cz>
References: <20031120031137.GA8465@bougret.hpl.hp.com> <3FBC3483.4060706@pobox.com> <20031120033422.GA8674@bougret.hpl.hp.com> <20031121120534.GA20822@ucw.cz> <20031121172541.GB25453@bougret.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121172541.GB25453@bougret.hpl.hp.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 21, 2003 at 09:25:41AM -0800, Jean Tourrilhes wrote:
> On Fri, Nov 21, 2003 at 01:05:34PM +0100, Vojtech Pavlik wrote:
> > On Wed, Nov 19, 2003 at 07:34:22PM -0800, Jean Tourrilhes wrote:
> > 
> > > 	Excuse me ? Have you looked at the Howto lately ? There is
> > > only Broadcom and Intel which are not supported, which leaves plenty
> > > of choice (including many 802.11g and 802.11a cards).
> > 
> > And Realtek (I own one such card) and ADMtek (I bought one by accident
> > in Canada) and Atheros and ... basically anything CardBus doesn't work.
> 
> 	Wrong. There are wireless drivers for RealTek, ADMtek and
> Atheros.
> 	I may repeat myself like a parrot, but "Have you looked at the
> Howto lately ?". I think you exactly prove my point ;-)

Yes, I've looked at the howto several times, and even downloaded the
drivers.

You may have missed the second paragraph I wrote:

>>> Well, you might say that those have Linux drivers, although they're
>>> binary only, but that's about as useful as none if one has a 2.6 kernel.

Now I was wrong in a couple points:

	As Linus pointed to me, the Atheros driver now works even with 2.6. 

	They're not binary only, but part-binary, which is somewhat better
	(not dependent on exact kernel version, just on compiler version and
	kernel major version).

But still both the Realtek and ADMtek drivers are useless with 2.6.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

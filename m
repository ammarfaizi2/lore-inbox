Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262141AbVGFIFK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262141AbVGFIFK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262144AbVGFIFJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:05:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61872 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262141AbVGFGcL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:32:11 -0400
Date: Tue, 5 Jul 2005 23:31:59 -0700
From: Chris Wright <chrisw@osdl.org>
To: Jussi Hamalainen <count@theblah.fi>
Cc: Chris Wright <chrisw@osdl.org>, Thomas Backlund <tmb@mandriva.org>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       Andy <genanr@emsphone.com>
Subject: Re: WARNING : kernel 2.6.11.7 (others) kills megaraid 4e/Si dead
Message-ID: <20050706063158.GY9046@shell0.pdx.osdl.net>
References: <20050503151532.GA1316@thumper2> <20050503190005.GS23013@shell0.pdx.osdl.net> <42CA9E93.1050802@mandriva.org> <20050705155808.GI9153@shell0.pdx.osdl.net> <Pine.LNX.4.62.0507060735570.24203@mir.senvnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507060735570.24203@mir.senvnet.fi>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jussi Hamalainen (count@theblah.fi) wrote:
> On Tue, 5 Jul 2005, Chris Wright wrote:
> 
> >>Any news on this matter?
> >>I hvr a PE1850 waiting for kernel upgrade, but I'm afraid to do so now...
> >>
> >>I can't break my box with tests since it's in active use...
> >>For now I'm running a 2.6.8.1 based kernel on the box...
> >
> >Last known good one (that Andy tested) was 2.6.10.  His was the only
> >report I've seen, and I haven't found any more details on it.
> 
> I have several PE1850s running 2.6.11.10 and above. I have never had 
> a megaraid controller die on me. This might be something related to a 
> particular firmware version or setup. I could check the firmware 
> versions if you want.

Good to hear.  Andy gave this firmware info:

  Megaraid (256 mb cache), firmware : 516A BIOS : H418

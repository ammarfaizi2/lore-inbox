Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUH1Rlw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUH1Rlw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267351AbUH1Rlv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:41:51 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:2229 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267535AbUH1Rjr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:39:47 -0400
Date: Sat, 28 Aug 2004 18:45:27 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hamie <hamish@travellingkiwi.com>
Cc: Alexander Rauth <Alexander.Rauth@promotion-ie.de>,
       linux-kernel@vger.kernel.org
Subject: Re: radeonfb problems (console blanking & acpi suspend)
Message-ID: <20040828164517.GA3048@openzaurus.ucw.cz>
References: <1093277876.9973.15.camel@pro30.local.promotion-ie.de> <20040824110024.GA3502@openzaurus.ucw.cz> <412BB8FF.3090601@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412BB8FF.3090601@travellingkiwi.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >>2) after an acpi suspend the backlight goes back on but there is no 
> >>data
> >>displayed on the screen (no X running nor started since boot)
> >>
> >>If more information is needed for diagnosis then please email me.
> >>   
> >>
> >
> >Known problem for suspend-to-ram, see Ole Rohne's patches.
> > 
> >
> Really? I use 2.6.8.1 on an r50p with radeonfb enabled, and don't 
> experience this... But I do run X as well (X.Org) with the X.Org 

It works with some bioses, breaks with other...
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         


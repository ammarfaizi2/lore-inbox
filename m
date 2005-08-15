Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964932AbVHOUNE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964932AbVHOUNE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVHOUNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:13:04 -0400
Received: from s243.chello.upc.cz ([62.24.84.243]:64925 "EHLO suse.cz")
	by vger.kernel.org with ESMTP id S964932AbVHOUNC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:13:02 -0400
Date: Mon, 15 Aug 2005 22:13:47 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: mr.fred.smoothie@pobox.com
Cc: Joe Peterson <joe@skyrush.com>, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] to drivers/input/evdev.c to add mixer device "/dev/input/events"
Message-ID: <20050815201347.GA1651@ucw.cz>
References: <4300D09C.4030702@skyrush.com> <20050815174558.GB1450@ucw.cz> <4300D845.8070605@skyrush.com> <20050815185729.GA1450@ucw.cz> <4300EF7C.9020500@skyrush.com> <161717d505081513066c660129@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161717d505081513066c660129@mail.gmail.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 04:06:04PM -0400, Dave Neuer wrote:

> On 8/15/05, Joe Peterson <joe@skyrush.com> wrote:
> > 
> > So, overall, I agree that we should not invent hacks to make up for
> > another software package's problems...
> 
> but also wrote:
> 
> > If the kernel could handle that aspect, it would make all programs more stable.
> 
> which seems a little contradictory.
> 
> However, Joe continued with:
> 
> > It does not sound right to push the handling of the intermittent nature
> > to each user program.
> 
> Indeed. Each user program should not care about it. An event/hotplug
> library should, and the user programs should use that. Like d-bus/HAL.
 
Yep. Exactly so.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

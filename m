Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271725AbTGRG47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 02:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271726AbTGRG47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 02:56:59 -0400
Received: from lorien.emufarm.org ([66.93.131.57]:1410 "EHLO
	lorien.emufarm.org") by vger.kernel.org with ESMTP id S271725AbTGRG47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 02:56:59 -0400
Date: Fri, 18 Jul 2003 00:07:49 -0700
From: Danek Duvall <duvall@emufarm.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O6.1int
Message-ID: <20030718070749.GA12466@lorien.emufarm.org>
Mail-Followup-To: Danek Duvall <duvall@emufarm.org>,
	Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org
References: <200307171635.25730.kernel@kolivas.org> <20030717080436.GA16509@lorien.emufarm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030717080436.GA16509@lorien.emufarm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After fixing my nice +5 problem, I'm still seeing pretty much the same
behavior, only with the priority values lowered by five.  The entire
desktop seems a bit snappier when not under load.

I got significantly more skipping in xmms under 2.6.0-test1 than under
the O6.1 patch this time, rather than the two being seemingly the same.
The scrolling behavior in mozilla was pretty much identical to how I
described it before.

I did discover under O6.1int that I could make xmms block indefinitely
when opening a window, with fvwm's wire frame manual placement, which I
hadn't ever noticed before, but I'm not sure if that's because it
actually wasn't there before, or I just placed the windows more quickly.

So, ultimately, no real difference.

Danek

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263332AbTEPRjC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 13:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTEPRjC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 13:39:02 -0400
Received: from h-68-165-86-241.DLLATX37.covad.net ([68.165.86.241]:35899 "EHLO
	sol.microgate.com") by vger.kernel.org with ESMTP id S263332AbTEPRjB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 13:39:01 -0400
Subject: Re: Test Patch: 2.5.69 Interrupt Latency
From: Paul Fulghum <paulkf@microgate.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       johannes@erdfelt.com,
       USB development list <linux-usb-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0305161316380.1171-100000@ida.rowland.org>
References: <Pine.LNX.4.44L0.0305161316380.1171-100000@ida.rowland.org>
Content-Type: text/plain
Organization: 
Message-Id: <1053107496.2606.25.camel@toshiba>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 16 May 2003 12:51:36 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-16 at 12:20, Alan Stern wrote:

> Well, I have actually seen false indications.  Whether they are due to
> noise is open to debate.  Since they occur just at the time when I turn
> the power to my USB peripheral on or off, that's my best guess.  It might
> even turn out that power on/off generates a temporary OC condition, so
> fixing that might render the grace period unnecessary.  I haven't had a
> chance try it yet.

That sounds like a reasonable explanation.

-- 
Paul Fulghum
paulkf@microgate.com


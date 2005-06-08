Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVFHTx7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVFHTx7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:53:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVFHTx7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:53:59 -0400
Received: from mx1.redhat.com ([66.187.233.31]:55519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261580AbVFHTxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:53:40 -0400
Date: Wed, 8 Jun 2005 15:53:36 -0400
From: Dave Jones <davej@redhat.com>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mtrr question
Message-ID: <20050608195336.GL876@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nick Warne <nick@linicks.net>, linux-kernel@vger.kernel.org
References: <200506081917.09873.nick@linicks.net> <200506082031.59987.nick@linicks.net> <20050608193556.GI876@redhat.com> <200506082047.13914.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506082047.13914.nick@linicks.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2005 at 08:47:13PM +0100, Nick Warne wrote:
 > On Wednesday 08 June 2005 20:35, Dave Jones wrote:
 > > On Wed, Jun 08, 2005 at 08:31:59PM +0100, Nick Warne wrote:
 > >  > Ummm.  I see from boot logs that mtrr isn't detected like it is on my
 > >  > other (Dell) boxes.
 > >
 > > Hmm, that sounds like it isn't compiled in. Though that doesn't make
 > > sense why you still have a /proc/mtrr
 > 
 > OK, ignore my previous comment (too many Linux boxes here).  The one I am 
 > investigating is my main Desktop, and dmesg confirms.  mtrr is detected as 
 > 'Intel' which is right as per the Docs (even though I have an AMD).
 > 
 > I also forgot to say I use the nVidia agp module (works better for me in 
 > Quake2 for some reason)... but searching their docs doesn't even mention 
 > mtrr.
 > 
 > Could it be that?  If so, I am wasting you guys time.

Maybe. I don't use non-free drivers, so I have no idea
what nvidia are/aren't doing in their driver.

I'd suggest trying the nvidia forums.

		Dave


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261787AbULBWgX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261787AbULBWgX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 17:36:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbULBWgX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 17:36:23 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:20493 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261787AbULBWgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 17:36:18 -0500
Date: Thu, 2 Dec 2004 14:34:49 -0800
To: Andrew Burgess <aab@cichlid.com>
Cc: linux-kernel@vger.kernel.org, jackit-devel@lists.sourceforge.net
Subject: Re: Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.31-19
Message-ID: <20041202223449.GA20728@nietzsche.lynx.com>
References: <200412021546.iB2FkK5a005502@cichlid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412021546.iB2FkK5a005502@cichlid.com>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 07:46:20AM -0800, Andrew Burgess wrote:
> A big thank you to Ingo and everyone else involved on behalf of all the
> linux audio users!

This is going to have a lot of ripple effect throughout the Linux
community in that game developers will quite possibly have the ability
to do low latency OpenGL, frame accurate video and other things along
those lines. The previous Linux kernels without these mods couldn't
allow this level of temporal precious for application developers. It's
going to push applications like jackd and others in ways that will
flush out bugs and general techniques that aren't typically apart of
a proper RT applications.

We have the possibility of providing a first class gaming platform and
other things, that Longhorn can't beging to touch if the middleware
falls into place. :)

bill


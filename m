Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWCYEyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWCYEyQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 23:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWCYEyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 23:54:15 -0500
Received: from mail.gmx.de ([213.165.64.20]:43908 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1750936AbWCYEyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 23:54:15 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.16-mm1 grub oddness
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060324102537.1d426594.akpm@osdl.org>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <1143201413.7741.53.camel@homer>  <20060324102537.1d426594.akpm@osdl.org>
Content-Type: text/plain
Date: Sat, 25 Mar 2006 05:55:01 +0100
Message-Id: <1143262501.7930.4.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-03-24 at 10:25 -0800, Andrew Morton wrote:
> Mike Galbraith <efault@gmx.de> wrote:
> >
> > Greetings,
> > 
> > I'm seeing strange things with grub with this kernel.  After my box has
> > been up for a while, and I reboot, selecting a kernel to restart, upon
> > reboot, I sometimes (fairly often) get a blank screen staring at me
> > though I see grub doing it's thing.  Poking the power button results in
> > an immediate poweroff, not as if the kernel had panicked or whatnot very
> > early in boot.  Very odd, and never before seen.
> > 
> 
> Do you mean that grub is actually proceeding as expected, just that the
> display is off?  If so, does it ever come back on?

No, the box just sits there and does nada.

	-Mike


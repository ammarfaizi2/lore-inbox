Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTDXFDJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:03:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264400AbTDXFDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:03:09 -0400
Received: from holomorphy.com ([66.224.33.161]:12455 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264394AbTDXFDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:03:04 -0400
Date: Wed, 23 Apr 2003 22:15:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flame Linus to a crisp!
Message-ID: <20030424051510.GK8931@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 08:59:45PM -0700, Linus Torvalds wrote:
> Comments? I'd love to get some real discussion about this, but in the end 
> I'm personally convinced that we have to allow it.
> Btw, one thing that is clearly _not_ allowed by the GPL is hiding private
> keys in the binary. You can sign the binary that is a result of the build
> process, but you can _not_ make a binary that is aware of certain keys
> without making those keys public - because those keys will obviously have
> been part of the kernel build itself.
> So don't get these two things confused - one is an external key that is
> applied _to_ the kernel (ok, and outside the license), and the other one
> is embedding a key _into_ the kernel (still ok, but the GPL requires that
> such a key has to be made available as "source" to the kernel).

I'm not particularly interested in the high-flown moral issues, but
this DRM stuff smelled like nothing more than a transparent ploy to
prevent anything but bloze from booting on various boxen to me.

But I suppose it could be used to force particular versions of Linux
to be used, e.g. ones with particular patches that do permissions
checks or various things meant to prevent warezing.

I'm largely baffled as to what this has to do with Linux kernel
hacking, as DRM appeared to me to primarily be hardware- and firmware-
level countermeasures to prevent running Linux at all, i.e. boxen we're
effectively forbidden from porting to. Even if vendors distribute their
own special Linux kernels with patches for anti-warezing checks that
boot on the things, the things are basically still just off-limits.

I guess there are other subtleties that fall out of it, like the DRM
stuff might be the only game in town so just not buying hardware you
don't like doesn't work, and just what the heck you paid for if you
can't use the stuff the way you want to (in theory, you could buy a
disk to use as a hockey puck, but this says you have to have some
magic kernel's notion of how to use it), but I'm hard-pressed to get
worked up about it. I'll just take up underwater basket weaving and
replace my computer with a typewriter and a calculator if it really
gets all that bad.


-- wli

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264538AbUHGWo3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264538AbUHGWo3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 18:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbUHGWo3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 18:44:29 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:6064 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S264538AbUHGWo1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 18:44:27 -0400
Date: Sat, 7 Aug 2004 23:42:34 +0100
From: Dave Jones <davej@redhat.com>
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: Keith Whitwell <keith@tungstengraphics.com>, Ian Romanick <idr@us.ibm.com>,
       Dave Airlie <airlied@linux.ie>,
       "DRI developer's list" <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: DRM function pointer work..
Message-ID: <20040807224234.GD26791@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jon Smirl <jonsmirl@yahoo.com>,
	Keith Whitwell <keith@tungstengraphics.com>,
	Ian Romanick <idr@us.ibm.com>, Dave Airlie <airlied@linux.ie>,
	DRI developer's list <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>
References: <4113BDC0.6050604@tungstengraphics.com> <20040806174645.77462.qmail@web14924.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040806174645.77462.qmail@web14924.mail.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06, 2004 at 10:46:45AM -0700, Jon Smirl wrote:
 > There are three main ways to get a driver:
 > 1) vendor release - most stable, I get one every two weeks
 > 2) Linus bk - very up to date, not as well tested, once a day
 > 3) copy DRM CVS into Linus bk - bleeding edge, hope you know what you
 > are doing.

In the case of bleeding edge Fedora, (Ie FC3 t1 right now), 1 and 2 are
the same. Ie, we rebase to the upstream -bk release almost daily.
(The only time we don't is when both myself and Arjan are otherwise
 occupied, like recently at OLS etc, but it's rare that both of us
 are too busy to do a rebase).

The current release version of Fedora (Ie, FC2 right now) has a slightly
less aggressive update cycle, typically only when either a) the upstream
kernel has fixed a lot of bugs that have been biting users, or b) there's
a security problem to justify another update.

		Dave


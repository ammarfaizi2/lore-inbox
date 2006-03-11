Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWCLANu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWCLANu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Mar 2006 19:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbWCLANu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Mar 2006 19:13:50 -0500
Received: from mail.shareable.org ([81.29.64.88]:62092 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1751335AbWCLANu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Mar 2006 19:13:50 -0500
Date: Sat, 11 Mar 2006 20:48:30 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Jonathan McDowell <noodles@earth.li>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Trivial removal of long incorrect address for Jamie Lokier
Message-ID: <20060311204830.GA3895@mail.shareable.org>
References: <20060311181658.GE1884@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060311181658.GE1884@earth.li>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan McDowell wrote:
> I know for a fact Jamie hasn't lived here for at least 5 years; a friend
> now owns it and while it's all well and good being able to find his
> postcode by grepping a kernel tree it should really go I guess.
> 
> Signed-off-by: Jonathan McDowell <noodles@earth.li>

Nice place isn't it?  I've lived in 7 other houses since then.

Twice I sent patches to the CREDITS file, a while back, to 2.4 and 2.6
maintainers and to the CREDITS maintainer when there was one, and
received no response from anyone, nor were the patches applied.
Bit of a weak spot there?

If someone's going to take the update this time, let's make it the
right one. :)

Credits update for Jamie Lokier.

Signed-off-by: Jamie Lokier <jamie@shareable.org>

--- linux-2.6.16-rc5/CREDITS.orig	2006-03-11 18:07:40.000000000 +0000
+++ linux-2.6.16-rc5/CREDITS	2006-03-11 18:07:56.000000000 +0000
@@ -2008,13 +2008,14 @@
 S: Ecole Nationale Superieure des Telecommunications, Paris

 N: Jamie Lokier
-E: jamie@imbolc.ucc.ie
+E: jamie@shareable.org
+W: http://www.shareable.org/
 D: Reboot-through-BIOS for broken 486 motherboards
-D: Some parport fixes
-S: 11 Goodson Walk
-S: Marston
+D: Parport fixes, futex improvements
+D: First instruction of x86 sysenter path :)
+S: 51 Sunningwell Road
 S: Oxford
-S: OX3 0HX
+S: OX1 4SZ
 S: United Kingdom

 N: Mark Lord

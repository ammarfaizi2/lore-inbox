Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751088AbWGZU5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751088AbWGZU5L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 16:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbWGZU5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 16:57:11 -0400
Received: from 8f.7b.d1c4.cidr.airmail.net ([209.196.123.143]:61450 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S1751154AbWGZU5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 16:57:10 -0400
From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 26 Jul 2006 15:56:29 -0500
To: linux-kernel@vger.kernel.org
Subject: genirq patches in -mm
Message-ID: <20060726205629.GA19224@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I was looking over the broken-out patches in the latest -mm series, and
found a number of genirq patches. I've not been building the -mm kernels
on my machine, just the plain kernels periodically updated from Linus'
repository. I would like, though, to get the genirq stuff and try it
out on my machine. What I don't know is which of the genirq patches to
apply, or if any other non-genirq patches in the set are needed in
addition to the genirq patches.

If these patches are planned to be added into the 2.6.18 queue I'll just
wait for them to show up in Linus' tree, but if not could someone post
a list (or patchset) as to which ones should be applied to make the
kernel on i386 utilize the new genirq code.

Thanks in advance.

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

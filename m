Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbVBWPeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbVBWPeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 10:34:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVBWPeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 10:34:23 -0500
Received: from elided.info ([24.173.235.14]:57985 "EHLO elided.info")
	by vger.kernel.org with ESMTP id S261350AbVBWPeR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 10:34:17 -0500
Date: Wed, 23 Feb 2005 15:35:34 +0000 (UTC)
From: Rob Levin <04wdxti1@somegeek.org>
To: linux-kernel@vger.kernel.org
Subject: Freenode, Tor, Linux channels (Was: Slightly OT: We should move
 linux...)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Message-Id: <E1D3yY2-0002EZ-2b@elided.info>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

> Today lilo (the FreeNode network owner) has decided to make one step away
> in a direction opposite of freedom, and banned all Tor users from the
> FreeNode network.

The actual PDPC policy on access to Freenode via the Electronic Frontier
Foundation's Tor project is here:

   http://freenode.net/policy.shtml#tor

To summarize, freenode supports the Tor project and works closely with its
developers.  Any anonymizing service can be abused, and we have to deal on a
daily basis with the results of such abuse.  Freenode provides Tor users
with randomly-generated, per-session, easily-identifiable hostname cloaks
and thus gives each channel the option of either allowing access to Tor
users or denying it.

We do occasionally block access from Tor exit nodes or remove Tor users from
the network, in the course of trying to deal with attacks on channels. 
We're trying to cut down. ;) For example, this morning we repeatedly killed
out a small clonebot net that was causing problems on unattended channels. 
We added the capability of specifically turning off new Tor connections
during periods when there's no other way to prevent abuse. In the process of
resolving bugs in that new network feature, we killed out several legitimate
Tor users by mistake. Nevertheless, we're committed to keeping freenode
available to Tor users as continuously as it is possible to do so.

Patrick, I'm sorry you felt the need to spam multiple community mailing
lists with this distorted interpretation of freenode policy.  I'm willing to
assume that you are simply ignorant of network policy, rather than advancing
some malicious agenda.

I'm posting this single reply in LKML only, to try to avoid adding to
off-topic discussion in the mailing lists Patrick has posted his comments
in; anyone who feels the need can quote this email in some other forum.

Regards,


Robert Levin
Head of Staff, freenode
Executive Director, PDPC
----
Peer-Directed Projects Center
10100 Main Street #31 /Houston, Texas 77025-5237 USA
Ph. +1.832.4768694

PDPC is a Texas nonprofit corporation and an IRS 501(c)(03) charitable and
educational organization, chartered in 2002 to provide resources to
peer-directed projects, including those of the Free and Open Source Software
communities.  PDPC runs the freenode interactive network.


Return-Path: <linux-kernel-owner+w=401wt.eu-S1030392AbWLTWRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030392AbWLTWRS (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030385AbWLTWRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:17:17 -0500
Received: from smtp.osdl.org ([65.172.181.25]:44338 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030379AbWLTWRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:17:16 -0500
Date: Wed, 20 Dec 2006 14:14:38 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: What's in git.git (stable), and Announcing GIT 1.4.4.3
In-Reply-To: <86vek6z0k2.fsf@blue.stonehenge.com>
Message-ID: <Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net> <86vek6z0k2.fsf@blue.stonehenge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Dec 2006, Randal L. Schwartz wrote:
> 
> Is this really in master?  I'm still seeing one-hour times on
> my Mac, using 8336afa563fbeff35e531396273065161181f04c.

Master right  now is at 54851157ac.

But I use the master site of kernel.org, and the public site mirrors 
probably haven't mirrored out yet.

Sometimes it can be worth it trying "git2.kernel.org" rather than 
"git.kernel.org", because the way the DNS round-robin works (badly), git1 
seems to get a lot more load than git2, so sometimes git2 gets updated 
before git1 does.

		Linus

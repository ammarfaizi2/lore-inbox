Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbTIXH44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 03:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261246AbTIXH4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 03:56:55 -0400
Received: from 7.Red-80-37-235.pooles.rima-tde.net ([80.37.235.7]:42934 "EHLO
	pau.newtral.org") by vger.kernel.org with ESMTP id S261162AbTIXH4z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 03:56:55 -0400
Date: Wed, 24 Sep 2003 09:56:52 +0200 (CEST)
From: Pau Aliagas <linuxnow@newtral.org>
X-X-Sender: pau@pau.intranet.ct
To: lkml <linux-kernel@vger.kernel.org>
Cc: Andrea Arcangeli <andrea@suse.de>
Subject: Re: log-buf-len dynamic
In-Reply-To: <Pine.LNX.4.44.0309231524160.24527-100000@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0309240949560.2238-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Sep 2003, Linus Torvalds wrote:

> Use CVS and be happy. But don't complain to others that have needs that 
> CVS simply can't fill. 
> ....
> Indeed. That's pretty much all non-distributed stuff is useful for, from
> where I'm stading.  Small projects with a few developers and a lot of
> read-only stuff. And even there the developers will bitch about the
> limitations.
> 
> Sure, SVN makes branches cheaper, but you still have to work with them
> like under CVS, ie merging is a total disaster. And you still can't make 
> it your private repository.

No flame wars intended, but arch does this and more. See:
http://savannah.gnu.org/projects/gnu-arch

Distributed, complex merging, easy branches... and even a linux repository
from 0.1, not yet in the detail of the current cvs or bk, but easyly
achievable if anyone is interested in spending the time to import it.

Pau


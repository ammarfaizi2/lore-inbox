Return-Path: <linux-kernel-owner+w=401wt.eu-S1030413AbWLTWoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWLTWoY (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 17:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWLTWoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 17:44:24 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:60362 "EHLO
	fed1rmmtao12.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030408AbWLTWoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 17:44:23 -0500
From: Junio C Hamano <junkio@cox.net>
To: merlyn@stonehenge.com (Randal L. Schwartz)
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] daemon.c blows up on OSX
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
Date: Wed, 20 Dec 2006 14:44:14 -0800
In-Reply-To: <86ejquyz4v.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 14:35:12 -0800")
Message-ID: <7vhcvq6vcx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Lemme see if it breaks on OpenBSD as well.
>
> Oddly enough - it didn't. :)

Of course it didn't.  I was a bit more careful than usual with
this and fired up an OpenBSD bochs on my wife's machine to test
it before pushing out.

> running "git version 1.4.4.3.g5485" on my openbsd box, but I can't get
> there on my OSX box.

Sorry, I cannot be of immediate help -- I do not have one.



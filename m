Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbTIHNZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 09:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTIHNYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 09:24:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:52701 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262328AbTIHNYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 09:24:04 -0400
Date: Sat, 6 Sep 2003 17:08:17 +0200
From: Pavel Machek <pavel@suse.cz>
To: Larry McVoy <lm@work.bitmover.com>, CaT <cat@zip.com.au>,
       Larry McVoy <lm@bitmover.com>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
Subject: Re: Scaling noise
Message-ID: <20030906150817.GB3944@openzaurus.ucw.cz>
References: <20030903040327.GA10257@work.bitmover.com> <20030903041850.GA2978@krispykreme> <20030903042953.GC10257@work.bitmover.com> <20030903043355.GC2019@zip.com.au> <20030903050859.GD10257@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030903050859.GD10257@work.bitmover.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Maybe this is a better way to get my point across.  Think about more CPUs
> on the same memory subsystem.  I've been trying to make this scaling point

The point of hyperthreading is that more virtual CPUs on same memory
subsystem can actually help stuff.
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...


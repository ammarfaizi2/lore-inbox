Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268086AbUJSXrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268086AbUJSXrk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270147AbUJSXqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:46:37 -0400
Received: from gprs214-24.eurotel.cz ([160.218.214.24]:55680 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S268086AbUJSXSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 19:18:48 -0400
Date: Wed, 20 Oct 2004 01:18:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, John Cherry <cherry@osdl.org>
Subject: Re: 2.6.9-final (compile stats)
Message-ID: <20041019231830.GH1142@elf.ucw.cz>
References: <1098053688.3882.1.camel@lightning> <200410181347.36224.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410181347.36224.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I'd like to test this -final thing, but I don't use bitkeeper.  Is it 
> available as a separate patch?

You can get it from cvs:

time rsync -zav --delete rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5 .

...then do local checkout.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

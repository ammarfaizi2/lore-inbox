Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbUCBUEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 15:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbUCBUEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 15:04:33 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:9927 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261755AbUCBUEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 15:04:32 -0500
Date: Tue, 2 Mar 2004 15:04:21 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Steve Lee <steve@tuxsoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.4-rc1 problems with e100 & 3c59x
In-Reply-To: <008301c4005f$708fec70$e501a8c0@saturn>
Message-ID: <Pine.LNX.4.58.0403021443060.29087@montezuma.fsmlabs.com>
References: <008301c4005f$708fec70$e501a8c0@saturn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Mar 2004, Steve Lee wrote:

> I am using /etc/modprobe.conf and I don't load any modules manually.
> This is mostly a module kernel, the only problem I'm having is with the
> network.  2.6.3 does work with the drivers compiled in (but not as
> modules).  2.6.4-rc1 I can not get to work at all (modules or builtin).
> Thanks for your suggestion.

Ahh, the reason i mentioned that was because i switched to modular network
drivers myself and was editing the wrong /etc file. I also happen to have
an e100 and 3c59x which i wanted to load in a specific order. I take it
you've already verified module-init-tools versions as requested?

	Zwane


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270939AbTHSPQ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 11:16:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270726AbTHSPQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 11:16:07 -0400
Received: from panda.sul.com.br ([200.219.150.4]:36108 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id S270472AbTHSPKo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 11:10:44 -0400
Date: Tue, 19 Aug 2003 11:58:02 -0300
To: linux-kernel@vger.kernel.org
Subject: Re: Surges of repeated input events in 2.6.0-test3-bk1?
Message-ID: <20030819145802.GA23675@cathedrallabs.org>
References: <200308190609.44691.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200308190609.44691.rob@landley.net>
From: aris@cathedrallabs.org (aris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Every once in a while, I'll get a surge of repeated input events, repeating 
> really fast for about half a second.  Just now it was the m key repeating 
> really fast for about half a second when I only hit it once, and before that 
> I was scrolling a window down using the down arrow under the scrollbar with 
> the rat, and it surged down for about half a second when I only clicked it 
> once.  (Each time the result was equal to a half-dozen clicks/keypresses when 
> I only did one...)
i have the same thing in my notebook, seems to be something with at
keyboard driver, as using kbdrate fixes it.

-- 
aris


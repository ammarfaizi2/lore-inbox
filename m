Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265747AbUGDP7s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265747AbUGDP7s (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 11:59:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265750AbUGDP7s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 11:59:48 -0400
Received: from cachan-4-82-66-238-12.fbx.proxad.net ([82.66.238.12]:44720 "EHLO
	nestor.hd.free.fr") by vger.kernel.org with ESMTP id S265747AbUGDP7q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 11:59:46 -0400
Subject: Re: [ANNOUNCE] HYADES (ITEA) project -- Adeos/ia64
From: Philippe Gerum <rpm@xenomai.org>
Reply-To: rpm@xenomai.org
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: linux-kernel@vger.kernel.org, rpm@xenomai.org
In-Reply-To: <20040703205045.A3275@electric-eye.fr.zoreil.com>
References: <1088420554.1137.108.camel@localhost>
	 <20040703205045.A3275@electric-eye.fr.zoreil.com>
Content-Type: text/plain
Organization: Xenomai
Message-Id: <1088956421.679.51.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 04 Jul 2004 17:53:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-07-03 at 20:50, Francois Romieu wrote:
> Philippe Gerum <rpm@xenomai.org> :
> [...]
> > The Adeos/ia64 patch and others can also be found at the usual place:
> > http://download.gna.org/adeos/patches/
> 
> Two boring things you may consider:
> - split the big patch before it's too late

Split it according to patchlevel-dependent/sublevel-dependent code? I
guess it would be possible since the code already strictly enforces this
separation. A generic/arch-dep split could also take place. I need to
find the best way to do this without entering a maintenance hell,
though.

> - read the <censored> Documentation/CodingStyle 
> 

You mean stop acting like an heretic with my brain-damage indentation
style for instance? Oh, well... ok, I guess I should. Habits are better
lost anyway.

> The doc is nice btw.
> 

Thx.

> --
> Ueimor
-- 

Philippe.


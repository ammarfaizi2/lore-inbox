Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266002AbUBQFTC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 00:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266007AbUBQFTC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 00:19:02 -0500
Received: from dp.samba.org ([66.70.73.150]:27340 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266002AbUBQFTA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 00:19:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: zwane@linuxpower.ca, linux-kernel@vger.kernel.org,
       lhcs-devel@lists.sourceforge.net
Subject: Re: [PATCH][2.6-mm] split drain_local_pages 
In-reply-to: Your message of "Mon, 16 Feb 2004 15:06:54 -0800."
             <20040216150654.38935399.akpm@osdl.org> 
Date: Tue, 17 Feb 2004 16:07:34 +1100
Message-Id: <20040217051911.71D852C261@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20040216150654.38935399.akpm@osdl.org> you write:
> Pavel Machek <pavel@ucw.cz> wrote:
> >
> > The idea looks good to me, but there's something wrong with the patch:
> 
> Yes, it looks like Rusty fed me a load there.  Zwane's patch fixes it up
> though.

You knew that saying that would force me to figure out what happened,
didn't you?

Actually, looks like you removed cpuhotplug-02-drain_local_pages.patch.

This fix is fine though, and probably better.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

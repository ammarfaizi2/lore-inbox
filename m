Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWBXAQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWBXAQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 19:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWBXAQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 19:16:52 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:41346 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S932210AbWBXAQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 19:16:51 -0500
Date: Thu, 23 Feb 2006 16:19:51 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: Jonas Bofjall <jonas@gazonk.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [stable] reiserfs problem with 2.6.15.[234]
Message-ID: <20060224001951.GT3883@sorel.sous-sol.org>
References: <Pine.LNX.4.58.0602240105590.14689@gazonk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0602240105590.14689@gazonk.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jonas Bofjall (jonas@gazonk.org) wrote:
> The fix that enables the ReiserFS mount options causes my machine (whose
> root filesystem is on reiserfs) to instantly reboot. No idea why, I
> suspect some mount option enabled by default causes problems, but other
> machines with similar configurations seems unaffected.
> 
> I'll take my problem to the reiserfs list, I just wanted to give you an
> indication that even that oh-so-simple-bugfix can cause trouble.

Thanks for the note.  It's known, and fixed for next -stable release
(and already fixed in Linus' tree).

thanks,
-chris

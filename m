Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030603AbWBHUXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbWBHUXZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 15:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030602AbWBHUXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 15:23:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:35849 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1030603AbWBHUXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 15:23:23 -0500
Date: Wed, 8 Feb 2006 21:22:51 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Aaron D. Brooks" <aaron.brooks@sicortex.com>
Cc: linux-kernel@vger.kernel.org, Keith Owens <kaos@ocs.com.au>
Subject: Re: scripts/namespace.pl is not CROSS_COMPILE happy
Message-ID: <20060208202251.GA9550@mars.ravnborg.org>
References: <20060208184506.GS11744@sicortex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060208184506.GS11744@sicortex.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2006 at 01:45:06PM -0500, Aaron D. Brooks wrote:
> All,
> 
>     I see that this has come up before:
> 
>     http://lkml.org/lkml/2005/9/20/68
> 
> but I don't see the inclusion of these changes in the current Linus
> linux-2.6 git tree. Are the changes hanging out somewhere or were they
> shot down for some reason?
> 
>     I've attached an alternate patch which is a ever so slightly more
> clean (for some definitions of "clean").

Looks good and with same functionality as Keiths - which I lost somehow.
Will take care when I'm back from holiday end of next week.

	Sam

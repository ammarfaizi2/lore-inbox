Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261385AbVACFKc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261385AbVACFKc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 00:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261386AbVACFKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 00:10:30 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:57623 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261385AbVACFKV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 00:10:21 -0500
Date: Mon, 3 Jan 2005 06:11:21 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: kconfig:
Message-ID: <20050103051121.GC8113@mars.ravnborg.org>
Mail-Followup-To: Roman Zippel <zippel@linux-m68k.org>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20041230235146.GA9450@mars.ravnborg.org> <200501030134.37810.zippel@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501030134.37810.zippel@linux-m68k.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 03, 2005 at 01:34:36AM +0100, Roman Zippel wrote:
> Hi,
> 
> On Friday 31 December 2004 00:51, Sam Ravnborg wrote:
> 
> > Here follows a few kconfig patches.
> > Main purpose is to improve readability of the output when doing  search
> > and to inculde dependency information in the help text.
> 
> I completely missed that the search patch was already merged... :-(
> It wasn't ready yet, it was still a quick hack. I attached a patch which does 
> the basic cleanup, so that it not only works for the trivial cases.

Thanks - looks good at first sight.
I will give it a spin and post updated kconfig patches.

	Sam

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVA3Wbd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVA3Wbd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVA3Wbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 17:31:33 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:59409 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261812AbVA3Wbb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 17:31:31 -0500
Date: Sun, 30 Jan 2005 23:33:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] make 'make help' show all *config targets and update descriptions slightly.
Message-ID: <20050130223319.GE14816@mars.ravnborg.org>
Mail-Followup-To: Jesper Juhl <juhl-lkml@dif.dk>,
	Roman Zippel <zippel@linux-m68k.org>,
	kbuild-devel <kbuild-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.61.0501242201200.2798@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501242201200.2798@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 10:05:48PM +0100, Jesper Juhl wrote:
> 
> "make help" doesn't show "make randconfig" nor "make config" as options 
> and the description of oldconfig could be better (IMHO). Patch below adds 
> the missing targets to the help and updates the description of oldconfig.

Applied - the help for oldconfig definitely got better.

	Sam

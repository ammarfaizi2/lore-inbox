Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVCQVtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVCQVtI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 16:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbVCQVtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 16:49:07 -0500
Received: from pfepc.post.tele.dk ([195.41.46.237]:32797 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261226AbVCQVqy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 16:46:54 -0500
Date: Thu, 17 Mar 2005 22:47:52 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm4
Message-ID: <20050317214752.GD13119@mars.ravnborg.org>
References: <20050316040654.62881834.akpm@osdl.org> <1110985632l.8879l.0l@werewolf.able.es> <20050316132600.3f6e4df2.akpm@osdl.org> <1111012757l.17756l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111012757l.17756l.0l@werewolf.able.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you swear to me it does not have to build under gtk-1.2 (which with
> current Makefile I do not know how can it be done), there are many stock
> things that can be done automagically in 2.x, and not manually like in gtk-1.2.

People running old systems running only gtk 1.2 always have menuconfig
as 'escape' possibility.
So the price paid to have a cleaner gconfig seems OK.

I recommend to remove the gtk 1.2 cruft and focus on gtk 2.x.
If you do please work on top of Linus' latest and not -mm.

	Sam

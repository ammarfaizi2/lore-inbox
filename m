Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVLPVZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVLPVZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 16:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932439AbVLPVZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 16:25:45 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:46948 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932437AbVLPVZo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 16:25:44 -0500
Date: Fri, 16 Dec 2005 22:26:41 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Petr Baudis <pasky@ucw.cz>
Cc: zippel@linux-m68k.org, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/3] Link lxdialog with mconf directly
Message-ID: <20051216212641.GA27948@mars.ravnborg.org>
References: <20051212004159.31263.89669.stgit@machine.or.cz> <20051212191422.GB7694@mars.ravnborg.org> <20051212200817.GM10680@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051212200817.GM10680@pasky.or.cz>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 09:08:17PM +0100, Petr Baudis wrote:
> 
> Ok. I didn't want to pollute scripts/kconfig/ too much, but if it's ok
> by you, I can do it that way. I will submit another series later in the
> evening.

I've just done the renaming and relevant updates.
So you will deal with much smaller patches.

My kbuild tree is updated with the changes and will soon mirror out.

	Sam

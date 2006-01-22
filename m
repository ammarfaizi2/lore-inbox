Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751367AbWAVVTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWAVVTp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 16:19:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWAVVTp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 16:19:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:43016 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751367AbWAVVTo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 16:19:44 -0500
Date: Sun, 22 Jan 2006 22:19:26 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/slab: add kernel-doc for one function
Message-ID: <20060122211926.GB13980@mars.ravnborg.org>
References: <20060121203709.76613d31.rdunlap@xenotime.net> <20060122204507.GA11002@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060122204507.GA11002@admingilde.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 22, 2006 at 09:45:07PM +0100, Martin Waitz wrote:
> hoi :)
> 
> thanks, I applied all three patches to
> http://tali.admingilde.org/git/linux-docbook.git,
> and I guess Andrew will take care of merging them with Linus.

That is the responsibility of the subsystem maintainer - as you have
become now.
At least in the normal case Andrew suck in the git trees and leave it to
the git tree owners to push to Linus.

It's a bit different compared to when you just sent patches to Andrew.

	Sam

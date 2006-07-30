Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932439AbWG3TaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932439AbWG3TaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 15:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932444AbWG3TaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 15:30:19 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:36746 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932439AbWG3TaR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 15:30:17 -0400
Date: Sun, 30 Jul 2006 21:29:43 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nikita Danilov <nikita@clusterfs.com>, Joe Perches <joe@perches.com>,
       Martin Waitz <tali@admingilde.org>,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Christoph Hellwig <hch@infradead.org>,
       David Woodhouse <dwmw2@infradead.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
       Russell King <rmk@arm.linux.org.uk>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 00/12] making the kernel -Wshadow clean - The initial step
Message-ID: <20060730192943.GA31690@mars.ravnborg.org>
References: <200607301830.01659.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607301830.01659.jesper.juhl@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2006 at 06:30:01PM +0200, Jesper Juhl wrote:
> Ok, here we go again...
> 
> This is a series of patches that try to be an initial step towards making
> the kernel build -Wshadow clean.
I will take care of warnings in scripts/*
mconf/lxdialog warnings will be fixed in my lxdialog tree which has
enough patches to make your path of no real use.
And its a trivial fix from my side.

	Sam

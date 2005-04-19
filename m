Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVDSWsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVDSWsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 18:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVDSWsL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 18:48:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:7874 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261719AbVDSWsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 18:48:04 -0400
Date: Tue, 19 Apr 2005 15:49:44 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Petr Baudis <pasky@ucw.cz>
cc: Greg KH <greg@kroah.com>, Git Mailing List <git@vger.kernel.org>,
       linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
In-Reply-To: <20050419223945.GG9305@pasky.ji.cz>
Message-ID: <Pine.LNX.4.58.0504191548500.2274@ppc970.osdl.org>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com>
 <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <20050419194728.GA24367@kroah.com>
 <Pine.LNX.4.58.0504191316180.19286@ppc970.osdl.org> <20050419223945.GG9305@pasky.ji.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 20 Apr 2005, Petr Baudis wrote:
> 
> I will probably not buy git-export, though. (That is, it is merged, but
> I won't make git frontend for it.) My "git export" already does
> something different, but more importantly, "git patch" of mine already
> does effectively the same thing as you do, just for a single patch; so I
> will probably just extend it to do it for an (a,b] range of patches.

That's fine. It was a quick hack, just to show that if somebody wants to, 
the data is trivially exportable.

		Linus

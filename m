Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161309AbWFVUB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161309AbWFVUB6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161307AbWFVUB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:01:57 -0400
Received: from pasmtpa.tele.dk ([80.160.77.114]:9892 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161302AbWFVUBz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:01:55 -0400
Date: Thu, 22 Jun 2006 22:01:47 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       git@vger.kernel.org
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060622200147.GA10712@mars.ravnborg.org>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org> <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org> <20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com> <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm just constantly surprised by how people don't even seem to realize 
> what it can do sometimes. Part of it is that development has been pretty 
> active (and some of the things it can do simply weren't there three months 
> ago), but part of it must be because people don't even expect it to be 
> able to do something like that.

Personally I'm still missing two things:
1) A command to let me see what this Linus guy have applied compared to
my tree - without touching anything in my tree. bk changes -R
2) A dry-run of a fetch+pull. I can do that if I really study the man
pages I know. But "git pull --dry-run" would be more convinient.

Other than that I will say that I'm pleased with the funtionality that
I use - that's maybe 10% of the possibilities...

	Sam

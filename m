Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161202AbWFVUwU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161202AbWFVUwU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 16:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030398AbWFVUwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 16:52:20 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2442 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030397AbWFVUwU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 16:52:20 -0400
Date: Thu, 22 Jun 2006 22:52:17 +0200
From: Petr Baudis <pasky@suse.cz>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Greg KH <gregkh@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net, git@vger.kernel.org
Subject: Re: [GIT PATCH] USB patches for 2.6.17
Message-ID: <20060622205217.GE21864@pasky.or.cz>
References: <20060621220656.GA10652@kroah.com> <Pine.LNX.4.64.0606211519550.5498@g5.osdl.org> <20060621225134.GA13618@kroah.com> <Pine.LNX.4.64.0606211814200.5498@g5.osdl.org> <20060622181826.GB22867@kroah.com> <20060622183021.GA5857@kroah.com> <Pine.LNX.4.64.0606221239100.5498@g5.osdl.org> <20060622200147.GA10712@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060622200147.GA10712@mars.ravnborg.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, Jun 22, 2006 at 10:01:47PM CEST, I got a letter
where Sam Ravnborg <sam@ravnborg.org> said that...
> Personally I'm still missing two things:
> 1) A command to let me see what this Linus guy have applied compared to
> my tree - without touching anything in my tree. bk changes -R

You can cg-fetch / git fetch and then either "cg-log -m" or
"git log -r ..origin".

> 2) A dry-run of a fetch+pull. I can do that if I really study the man
> pages I know. But "git pull --dry-run" would be more convinient.

What would that involve? Isn't git pull --no-commit enough?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.

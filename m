Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261883AbVDKSpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261883AbVDKSpp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbVDKSpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:45:45 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3718 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261883AbVDKSpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:45:41 -0400
Date: Mon, 11 Apr 2005 20:45:38 +0200
From: Petr Baudis <pasky@ucw.cz>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: Re: GIT license (Re: Re: Re: Re: Re: [ANNOUNCE] git-pasky-0.1)
Message-ID: <20050411184538.GB22339@pasky.ji.cz>
References: <200504111546.j3BFkc330368@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504111546.j3BFkc330368@freya.yggdrasil.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  please do not trim the cc list so agressively.

Dear diary, on Mon, Apr 11, 2005 at 05:46:38PM CEST, I got a letter
where "Adam J. Richter" <adam@yggdrasil.com> told me that...
..snip..
> Graydon Hoare.  (By the way, I would prefer that git just punt to
> user level programs for diff and merge when all of the versions
> involved are different or at least have a very thin interface
> for extending the facility, because I would like to do some character
> based merge stuff.)
..snip..

But this is what git already does. I agree it could do it even better,
by checking environment variables for the appropriate tools (then you
could use that to pass diff e.g. -p etc.).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.

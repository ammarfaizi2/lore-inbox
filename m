Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132215AbRAFRnA>; Sat, 6 Jan 2001 12:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132226AbRAFRml>; Sat, 6 Jan 2001 12:42:41 -0500
Received: from srv8-bnu.bnu.terra.com.br ([200.248.48.18]:9738 "EHLO
	srv8-bnu.bnu.terra.com.br") by vger.kernel.org with ESMTP
	id <S132215AbRAFRma>; Sat, 6 Jan 2001 12:42:30 -0500
Date: Sat, 6 Jan 2001 15:40:27 -0200
From: Augusto César Radtke <radtke@conectiva.com>
To: "Jeremy M. Dolan" <jmd@foozle.turbogeek.org>
Cc: Matthias Juchem <juchem@uni-mannheim.de>, linux-kernel@vger.kernel.org
Subject: Re: Bug reporting script? (was: removal of redundant line in documentation)
Message-ID: <20010106154027.A1461@conectiva.com>
Mail-Followup-To: Augusto César Radtke <radtke@conectiva.com>,
	"Jeremy M. Dolan" <jmd@foozle.turbogeek.org>,
	Matthias Juchem <juchem@uni-mannheim.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <01010607054600.01947@gandalf> <20010106075402.A3377@foozle.turbogeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010106075402.A3377@foozle.turbogeek.org>; from jmd@foozle.turbogeek.org on Sat, Jan 06, 2001 at 07:54:02AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy M. Dolan wrote:

> If ver_linux can take off one of those steps, why not include a script
> which takes care of ALL the leg work? All of the files it asks the
> reporter to include are o+r...
> 
> I can whip up a bug_report script to walk the user though all of the
> steps in REPORTING-BUGS, if the list isn't averse to 'dumbing down'
> the process to the point where maybe some people who shouldn't be
> submiting bugs (two words: 'user error') end up not being scared off
> by the process.
> 
	
About bug reports, isn't a good thing introduce the sgi's lkcd (linux kernel crash dump) into the main stream of 2.5? The main problem of lkcd in 2.2 was the lack of kiobufs.

I think it as a good thing, for distributions, the distribution guys have the vmlinuz image of the distro, so when a bug happens the user only needs to send the crash dump to the distribution kernel hacker, and he can discuss the bug on lkml.

This introduce a new kind of bug reporter, if the distribution makes avalaible every new development kernel as a package, a user can download and use, crash and report the bug without any knowledge about kernel. So the marketing guys can say: 'help the development of linux without hacking, report bugs'.

Comments?
	
	Augusto
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

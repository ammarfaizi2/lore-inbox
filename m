Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUCWXRt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUCWXRs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:17:48 -0500
Received: from gprs214-90.eurotel.cz ([160.218.214.90]:16002 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262901AbUCWXRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:17:44 -0500
Date: Wed, 24 Mar 2004 00:17:15 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: ncunningham@users.sourceforge.net, Jonathan Sambrook <swsusp@hmmn.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on the merge?]
Message-ID: <20040323231715.GH364@elf.ucw.cz>
References: <1079661410.15557.38.camel@calvin.wpcb.org.au> <20040318200513.287ebcf0.akpm@osdl.org> <1079664318.15559.41.camel@calvin.wpcb.org.au> <20040321220050.GA14433@elf.ucw.cz> <1079988938.2779.18.camel@calvin.wpcb.org.au> <20040322231737.GA9125@elf.ucw.cz> <20040323095318.GB20026@hmmn.org> <20040323214734.GD364@elf.ucw.cz> <1080076132.12965.18.camel@calvin.wpcb.org.au> <opr5b7tyt24evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr5b7tyt24evsfm@smtp.pacific.net.th>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> <ncunningham@users.sourceforge.net> wrote:
> > I'm also of a mind to not include the original
> >text-mode 'nice display' and just use the Bootsplash support.
> 
> Which I would not agree with as this is what I use ;)
> 
> However could this be moved into a module or userland thus keeping everyone 
> happy.

Unfortunately, it can not be sanely moved to userland.

We probably could live with hooks for bootsplash (as long as they are
very few lines, code-wise), and you probably could hook your favourite
text-mode eye-candy there.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]

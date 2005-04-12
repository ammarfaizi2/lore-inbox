Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262459AbVDLN1j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262459AbVDLN1j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262454AbVDLNXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:23:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22935 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262459AbVDLNXM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 09:23:12 -0400
Date: Tue, 12 Apr 2005 15:23:07 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Martin Schlemmer <azarah@nosferatu.za.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Ross Vandegrift <ross@jose.lug.udel.edu>
Subject: Re: Re: Re: [ANNOUNCE] git-pasky-0.3
Message-ID: <20050412132307.GH22614@pasky.ji.cz>
References: <Pine.LNX.4.58.0504091320490.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091404350.1267@ppc970.osdl.org> <Pine.LNX.4.58.0504091617000.1267@ppc970.osdl.org> <20050410024157.GE3451@pasky.ji.cz> <20050410162723.GC26537@pasky.ji.cz> <20050411015852.GI5902@pasky.ji.cz> <20050411135758.GA3524@pasky.ji.cz> <1113310045.23299.15.camel@nosferatu.lan> <20050412130250.GG22614@pasky.ji.cz> <1113311595.23299.17.camel@nosferatu.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1113311595.23299.17.camel@nosferatu.lan>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Apr 12, 2005 at 03:13:15PM CEST, I got a letter
where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> On Tue, 2005-04-12 at 15:02 +0200, Petr Baudis wrote:
> > Dear diary, on Tue, Apr 12, 2005 at 02:47:25PM CEST, I got a letter
> > where Martin Schlemmer <azarah@nosferatu.za.org> told me that...
> > > On Mon, 2005-04-11 at 15:57 +0200, Petr Baudis wrote:
> > > >   Hello,
> > > > 
> > > >   here goes git-pasky-0.3, my set of patches and scripts upon
> > > > Linus' git, aimed at human usability and to an extent a SCM-like usage.
> > > > 
> > > 
> > > Its pretty dependant on where VERSION is located.  This patch fixes
> > > that. (PS, I left the output of 'git diff' as is to ask about the
> > > following stuff after the proper diff ...)
> > 
> > Thanks, applied. I don't understand your PS, though. :-)
> > 
> 
> Heh, yeah I do that sometimes.  Basically should 'git diff' output
> anything (besides maybe not added files like cvs ... sorry, do not know
> after what you fashion it) like it does now?

Huh. Well, git diff without any arguments should just call show-diff.
That is show your local uncommitted changes. It doesn't show the locally
added/removed files yet for several reasons, but it's being worked on.
:-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.

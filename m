Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbTLFVpN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 16:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265259AbTLFVpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 16:45:12 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:40153 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S265260AbTLFVpG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 16:45:06 -0500
Date: Sat, 6 Dec 2003 13:45:03 -0800
From: Larry McVoy <lm@bitmover.com>
To: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
       Erik Andersen <andersen@codepoet.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Paul Adams <padamsdev@yahoo.com>
Subject: Re: Linux GPL and binary module exception clause?
Message-ID: <20031206214503.GA17303@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>, Larry McVoy <lm@bitmover.com>,
	Erik Andersen <andersen@codepoet.org>,
	Zwane Mwaikambo <zwane@arm.linux.org.uk>,
	Paul Adams <padamsdev@yahoo.com>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com> <20031205004653.GA7385@codepoet.org> <Pine.LNX.4.58.0312041956530.27578@montezuma.fsmlabs.com> <20031205010349.GA9745@codepoet.org> <20031205012124.GB15799@work.bitmover.com> <Pine.LNX.4.58.0312041750270.6638@home.osdl.org> <20031206030037.GB28765@work.bitmover.com> <20031206141300.GA13372@pimlott.net> <20031206175041.GD28765@work.bitmover.com> <20031206211900.GA9034@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031206211900.GA9034@thunk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 06, 2003 at 04:19:00PM -0500, Theodore Ts'o wrote:
> But that aside, does the Open Source community really want to push for
> the legal principal that just because you write an independent program
> which uses a particular API, the license infects across the interface?
> That's essentially interface copyrights, and if say the FSF were to
> file an amicus curiae brief support that particular legal principle in
> an kernel modules case, it's worthwhile to think about how Microsoft
> and Apple could use that case law to f*ck us over very badly.  
> 
> It would mean that we would not be able to use Microsoft DLL's in
> programs like xine.  It would mean that programs like Crossover office
> wouldn't work.  It would mean that Apple could legally prohibit people
> from writing enhancements to MacOS (for example, how do all of the
> various extensions in Mac OS 9 work?  They link into the operating
> system and modify its behaviour.  If they are therefore a derived work
> of MacOS, then Apple could screw over all of the people who write
> system extensions of MacOS.)  
> 
> Be careful of what you wish for, before you get it.  The ramifications
> of the statement that just because a device driver is written for
> Linux, that it is presumptively a derived work of Linux unless proven
> otherwise, is amazingly scary.  Fortunately, we can hope that the law
> professor I talked to was right, and that such a claim would be
> laughed out of court.  But if it isn't, look to Microsoft and other
> unsavory companies to use that kind of case law to completely screw us
> to the wall.....

What Ted is saying is precisely what I have been trying to say for a long
time, he just said it better (thanks Ted).

If you want the rules to work a particular way when they benefit you you
have to be prepared to deal with it when someone else invokes the same 
rules against you.

I'm with Ted on this one, big time.  I agree that it is opening the door to
unbelievable amounts of bad juju from the corporate folks if licenses can
infect across APIs.  I'd personally like it if contracts couldn't do this
either.  The whole thing gives me more willies than the DMCA.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751621AbWH3XPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbWH3XPw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 19:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbWH3XPw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 19:15:52 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:8387 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751621AbWH3XPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 19:15:51 -0400
Date: Thu, 31 Aug 2006 01:15:37 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Crispin Cowan <crispin@novell.com>
Cc: David Safford <safford@watson.ibm.com>, Serge E Hallyn <sergeh@us.ibm.com>,
       Mimi Zohar <zohar@us.ibm.com>, David Safford <safford@us.ibm.com>,
       kjhall@us.ibm.com, linux-kernel <linux-kernel@vger.kernel.org>,
       LSM ML <linux-security-module@vger.kernel.org>,
       linux-security-module-owner@vger.kernel.org
Subject: Re: [RFC][PATCH 8/8] SLIM: documentation
Message-ID: <20060830231537.GL3923@elf.ucw.cz>
References: <20060817230213.GA18786@elf.ucw.cz> <OFA16BD859.1B593DA2-ON852571CE.005FA4FF-852571CE.004BD083@us.ibm.com> <20060824054933.GA1952@elf.ucw.cz> <20060824130340.GB15680@sergelap.austin.ibm.com> <20060824131127.GB7052@elf.ucw.cz> <1156442454.2476.46.camel@localhost.localdomain> <20060826101140.GE10257@elf.ucw.cz> <44F4DF11.20205@novell.com> <20060830225950.GI3923@elf.ucw.cz> <44F61B2E.5090603@novell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F61B2E.5090603@novell.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2006-08-30 16:11:42, Crispin Cowan wrote:
> Pavel Machek wrote:
> >> The Windows problem is foolish users who download something shiny, such
> >> as enhanced emoticons or a keen password caching mechanism (e.g. Gator)
> >> or games (as in David's example) which turns out to be spyware. Under
> >> David's demo, you can download and run the spyware, but it doesn't get
> >> access to the critical system files that make spyware so difficult to
> >> remove.
> >>     
> > Well, it gets access to my browser, which contains most of the stuff
> > spyware is interested in, anyway.
> >   
> It gets access to the data, but doesn't get to insert itself into
> important system files. An important attribute of spyware is that it is
> hard to remove, and this makes the "hard to remove" property much harder
> to achieve.

As I wrote in my previous email, yes, it makes it easier to remove.

Thinking about it, it may also make it hard to survive login/logout;
which is actually good point.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

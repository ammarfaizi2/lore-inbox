Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267713AbUIAWsl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267713AbUIAWsl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 18:48:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUIAWsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 18:48:31 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:49161 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S267713AbUIAWqZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 18:46:25 -0400
Date: Wed, 1 Sep 2004 15:45:26 -0700
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Markus T?rnqvist <mjt@nysv.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Andrew Morton <akpm@osdl.org>,
       hch@lst.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040901224526.GA19030@nietzsche.lynx.com>
References: <412D9FE6.9050307@namesys.com> <200408261812.i7QICW8r002679@localhost.localdomain> <20040827203216.GC1284@nysv.org> <Pine.LNX.4.58.0408271335421.14196@ppc970.osdl.org> <41305674.6030405@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41305674.6030405@namesys.com>
User-Agent: Mutt/1.5.6+20040818i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 28, 2004 at 02:55:00AM -0700, Hans Reiser wrote:
> mistakes the database guys make when they try to emulate file systems 
> without changing the core balanced tree algorithms, and their 
> performance sucked and they had to back off.  It took 11 years for me to 
> get it right, and they aren't as crazy-err-persistent as I am.;-)
> 
> We might get lucky and have them produce another NTFS, but then again, 
> when Microsoft focuses on a task, they do much better at it than they do 
> most of the time, and they are focused on WinFS.  They have hired very 
> sharp people.  We can hope that they don't know how to use them, but 
> when they hire people like Gerard Salton for $1 million a year, there is 
> just possibly a chance that they might try to get their money's worth 
> out of him.

I realize this is a relatively late reply, but...

MS's problem is that they hire very smart folks, but the compartimentalize
them so they don't influence the overall architecture of the entire system.
I guarantee you that even if they did get all of this in place and working,
their arrogance in this matter will screw up how this will be properly used
and never expressed the power of a system like this.

Apple is another story. They're the only other folks that might get this right.

Your system is a dream of mine since I was dorking around with persistent
objects in Smalltalk systems. But getting other folks to understand
something like this and then use it in this way is very difficult and I
don't expect MS to be able to do this nor get .NET to compete with Java
for server side applications. I don't expect traditional Unix folks to
understand why something like this is important also.

It's not about a single technology as much as the system as a whole,
larger picture... That's were a system starts to show it's superiority.

That's my two cents on the matter.

bill


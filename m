Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbVDVA0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbVDVA0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 20:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbVDVAXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 20:23:25 -0400
Received: from w241.dkm.cz ([62.24.88.241]:12684 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261823AbVDVAVy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 20:21:54 -0400
Date: Fri, 22 Apr 2005 02:21:50 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050422002150.GY7443@pasky.ji.cz>
References: <Pine.LNX.4.58.0504201728110.2344@ppc970.osdl.org> <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050421232201.GD31207@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 01:22:01AM CEST, I got a letter
where Pavel Machek <pavel@ucw.cz> told me that...
> Hi!

Hi,

> > > > You should put this into .git/remotes
> > > > 
> > > > linus	rsync://www.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> > 
> > (git addremote is preferred for that :-)
> 
> Nice, so I now have my own -git tree, with two changes in it...
> 
> Is there way to say "git diff -r origin:" but dump it patch-by-patch
> with some usable headers?
> 
> [Looking at git export]

Either Linus' demo git-export (NOT the same as git export!), or git
patch. In the latest tree, it was extended to accept a range of two
commits to process too.

Note that the range semantics is rather peculiar at the least. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVDWXGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVDWXGv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 19:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbVDWXGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 19:06:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57015 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261806AbVDWXGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 19:06:49 -0400
Date: Sun, 24 Apr 2005 01:06:48 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.12-rc3
Message-ID: <20050423230648.GE13222@pasky.ji.cz>
References: <20050421112022.GB2160@elf.ucw.cz> <20050421120327.GA13834@elf.ucw.cz> <20050421162220.GD30991@pasky.ji.cz> <20050421232201.GD31207@elf.ucw.cz> <20050422002150.GY7443@pasky.ji.cz> <20050422231839.GC1789@elf.ucw.cz> <Pine.LNX.4.58.0504221718410.2344@ppc970.osdl.org> <20050423111900.GA2226@openzaurus.ucw.cz> <Pine.LNX.4.58.0504230654190.2344@ppc970.osdl.org> <20050423230023.GA17388@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423230023.GA17388@elf.ucw.cz>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Apr 24, 2005 at 01:00:23AM CEST, I got a letter
where Pavel Machek <pavel@ucw.cz> told me that...
> I created three trees here (with git fork): one ("clean-git") to track
> your changes, second ("linux-git") to do my development on and third
> ("linux-good") for good, nice, cleaned-up changes, for you to merge.
> 
> ...unfortunately pasky's git just symlinked object/ directories...

You can't do any better than that, since you would have to transfer
stuff around by pulling them otherwise; so you would need smart git
pull, but then Linus can use the smart git pull himself anyway. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

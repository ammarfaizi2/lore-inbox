Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbVDSXCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbVDSXCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 19:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVDSXCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 19:02:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42696 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261724AbVDSXCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 19:02:36 -0400
Date: Wed, 20 Apr 2005 01:02:33 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Steven Cole <elenstev@mesatop.com>, Greg KH <greg@kroah.com>,
       Greg KH <gregkh@suse.de>, Git Mailing List <git@vger.kernel.org>,
       linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [GIT PATCH] I2C and W1 bugfixes for 2.6.12-rc2
Message-ID: <20050419230233.GI9305@pasky.ji.cz>
References: <20050419043938.GA23724@kroah.com> <20050419185807.GA1191@kroah.com> <Pine.LNX.4.58.0504191204480.19286@ppc970.osdl.org> <426583D5.2020308@mesatop.com> <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504191525290.2274@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 12:38:17AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> Just say no to patches. 

FYI, I've - per Junio's suggestion - made git merge's fast-forward to
apply show-diff output as a patch instead. This is roughly equal to
doing the sanity check against local changes, except that it handles
them, while at it. (Tree merge refuses to work when there are local
changes.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

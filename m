Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVEMFoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVEMFoh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 01:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262252AbVEMFoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 01:44:37 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22245 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262249AbVEMFo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 01:44:26 -0400
Date: Fri, 13 May 2005 07:44:24 +0200
From: Petr Baudis <pasky@ucw.cz>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Matt Mackall <mpm@selenic.com>,
       linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
       mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Mercurial 0.4e vs git network pull
Message-ID: <20050513054424.GG16464@pasky.ji.cz>
References: <20050512205735.GE5914@waste.org> <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505121709250.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Thu, May 12, 2005 at 11:24:27PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> In the present mainline, you first have to find the head commit you
> want. I have a patch which does this for you over the same
> connection. Starting from that point, it tracks reachability on the
> receiving end, and requests anything it doesn't have.

Could we get the patch, please? :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor

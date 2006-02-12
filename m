Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751481AbWBLWdL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbWBLWdL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 17:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWBLWdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 17:33:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:37835 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751481AbWBLWdK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 17:33:10 -0500
Date: Sun, 12 Feb 2006 23:33:47 +0100
From: Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <junkio@cox.net>
Cc: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.2.0
Message-ID: <20060212223347.GZ31278@pasky.or.cz>
References: <7vzmkw8d5b.fsf@assigned-by-dhcp.cox.net> <7vaccw8bsc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7vaccw8bsc.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Feb 12, 2006 at 11:14:43PM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> For the full list of changes above, see:
> 
> 	$ git log ^v1.1.6 v1.1.0..v1.2.0

Actually, you can do just

 	$ git log v1.1.6..v1.2.0

since v1.1.6 is a superset of v1.1.0. It is like "list all new patches I
will get when I update from v1.1.6 to v1.2.0".

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams

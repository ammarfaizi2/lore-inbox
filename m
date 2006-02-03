Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946004AbWBCXvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946004AbWBCXvT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 18:51:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946005AbWBCXvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 18:51:19 -0500
Received: from mail.autoweb.net ([198.172.237.26]:34527 "EHLO
	mail.internal.autoweb.net") by vger.kernel.org with ESMTP
	id S1946004AbWBCXvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 18:51:18 -0500
Date: Fri, 3 Feb 2006 18:50:03 -0500
From: Ryan Anderson <ryan@michonline.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Linus Torvalds <torvalds@osdl.org>, Paolo Ornati <ornati@fastwebnet.it>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
Message-ID: <20060203235002.GA5580@mythryan2.michonline.com>
References: <43E39932.4000001@lwfinger.net> <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org> <43E3A001.7080309@lwfinger.net> <20060203205716.7ed38386@localhost> <43E3BF5A.3040305@lwfinger.net> <Pine.LNX.4.64.0602031258300.4630@g5.osdl.org> <43E3C703.20501@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43E3C703.20501@lwfinger.net>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 03:11:31PM -0600, Larry Finger wrote:
> 
> Thanks. I was almost ready to create aliases so that I would not have to 
> remember all those paths. My initial copy of git was obviously new enough 
> that .git/remotes/origin had the info. Now rid of rsync.

You may want to do a "git repack -a -d" to get everything condensed into
a single pack file.  It will likely take a while to run, however.

-- 

Ryan Anderson
  sometimes Pug Majere

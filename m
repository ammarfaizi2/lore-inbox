Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287488AbSBIUvo>; Sat, 9 Feb 2002 15:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287565AbSBIUvd>; Sat, 9 Feb 2002 15:51:33 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:34575 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S287488AbSBIUvO>; Sat, 9 Feb 2002 15:51:14 -0500
Date: Sat, 9 Feb 2002 21:51:10 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: pull vs push (was Re: [bk patch] Make cardbus compile in -pre4)
Message-ID: <20020209205110.GE32401@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020209181213.GA32401@come.alcove-fr> <Pine.LNX.4.33.0202091241080.1196-100000@home.transmeta.com> <20020209201252.GD32401@come.alcove-fr> <20020209122649.E13735@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020209122649.E13735@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2002 at 12:26:49PM -0800, Larry McVoy wrote:

> This is my problem.  You could help if you could tell me what exactly 
> are the magic wands to wave such that you can ssh in without typing
> a password. 

Set up $HOME/.shosts ? (man 1 ssh)

> > has again the latest version. Thanks! (or thanks Larry, whatever is 
> > more appropriate :-)).
> 
> Yeah, I did it by hand.  Hopefully automated by the end of the day.

Would it be possible to do something to keep the 2.4 tree up to date too ?
(something like checking if the latest incremental patch from kernel.org
was applied to the tree, and if not, apply it as a changeset and tag) ?

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com

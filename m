Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266976AbSLPR22>; Mon, 16 Dec 2002 12:28:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266977AbSLPR22>; Mon, 16 Dec 2002 12:28:28 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:55559 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266976AbSLPR20>; Mon, 16 Dec 2002 12:28:26 -0500
Date: Mon, 16 Dec 2002 12:36:21 -0500
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.52
Message-ID: <20021216173621.GZ504@hopper.phunnypharm.org>
References: <20021216151639.GQ504@hopper.phunnypharm.org> <Pine.LNX.4.44.0212160920380.2799-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212160920380.2799-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you think that "maintainer" means that nobody else can touch the tree
> and that you thus don't need to care, you're WRONG.

I never said that. What I said was that because I can't spend lots of
time tracking changes, _sometimes_ I miss them. You will see in the SVN
repo logs a lot of places where I merge in changes from your tree. It's
a fact that people make mistakes. I've already rectified this one by
adding in the patch to the linux1394 repo.

I wasn't pushing off blame, just noting that it's not possible to never
make mistakes. You make them too.


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

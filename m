Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284879AbRLKDji>; Mon, 10 Dec 2001 22:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284871AbRLKDj2>; Mon, 10 Dec 2001 22:39:28 -0500
Received: from opus.INS.CWRU.Edu ([129.22.8.2]:63175 "EHLO opus.INS.cwru.edu")
	by vger.kernel.org with ESMTP id <S284850AbRLKDjL>;
	Mon, 10 Dec 2001 22:39:11 -0500
Date: Mon, 10 Dec 2001 22:41:56 -0500
From: "Justin Hibbits <jrh29@po.cwru.edu>"@opus.INS.cwru.edu
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: Exporting GPLONLY symbols (Please CC to my email address)
Message-ID: <20011210224156.E14022@po.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Umm....I'm a new poster here to the list, but, nonetheless, I have a
small complaint about the track the kernel is taking with respect to
kernel modules, specifically the exporting of symbols as GPLONLY.  I
understand that several hackers are pushing to export many symbols as
GPLONLY, which I feel is a very bad idea.  The NVidia drivers will no
longer work, and any other module which depends on symbols which will
eventually be exported as GPLONLY will also no longer work.  Do you guys
really want to restrict everyone to using modules licensed under the
GPL?  I've read and understand the GPL all too well, and came to the
conclusion that it's a horrible license to begin with, given the simple
fact that Stallman's communist views are in it, forcing everything
licensed under it to be under every future license....with one change to
the license, he can claim all source licensed under the GPL.

I agree with Cox that something has to be done to warn the average user
that inserting closed source modules might cause something bad, and you
guys can't do anything about it, but FORCING all modules to become GPL
is the stupidest idea yet!  Linux is starting to take the road of M$,
forcing a one-licensed approach.  Not cool guys.

Those are my thoughts.

Justin Hibbits


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263324AbSJFE0p>; Sun, 6 Oct 2002 00:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263327AbSJFE0p>; Sun, 6 Oct 2002 00:26:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:8842 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263324AbSJFE0o>;
	Sun, 6 Oct 2002 00:26:44 -0400
Date: Sat, 05 Oct 2002 21:25:45 -0700 (PDT)
Message-Id: <20021005.212545.105431149.davem@redhat.com>
To: drepper@redhat.com
Cc: lm@bitmover.com, bcollins@debian.org, linux-kernel@vger.kernel.org
Subject: Re: New BK License Problem?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D9F49D9.304@redhat.com>
References: <3D9F3C5C.1050708@redhat.com>
	<20021005124321.D11375@work.bitmover.com>
	<3D9F49D9.304@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ulrich Drepper <drepper@redhat.com>
   Date: Sat, 05 Oct 2002 13:21:45 -0700
   
   You mentioned rsync to replicate the archive and then use CSSC.  Would
   be fine with me.  But: knowing how to set up rsync would probably
   require me to look at all the bk infrastructure and mechanisms more than
   I had to do in the whole time I was using bk the check out sources and
   while doing this I probably once again violate your license.

Not true, you just take the entire tree (like a tarball) and then run
SCCS get on it.

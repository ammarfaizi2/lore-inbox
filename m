Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265221AbUBOXbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 18:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265253AbUBOXbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 18:31:55 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:31571 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S265221AbUBOXbx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 18:31:53 -0500
Date: Sun, 15 Feb 2004 15:32:14 -0800
From: Paul Jackson <pj@sgi.com>
To: wrlk@riede.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove obsolete onstream support from ide-tape in
 2.6.3-rc3
Message-Id: <20040215153214.002dcc9a.pj@sgi.com>
In-Reply-To: <20040215221108.GA4957@serve.riede.org>
References: <20040215221108.GA4957@serve.riede.org>
Organization: SGI
X-Mailer: Sylpheed version 0.8.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

And another obsolete tape drive goes on my vintage shelf.

Willem - I notice off SourceForge a note:

  http://sourceforge.net/forum/forum.php?forum_id=333748

  Posted By: wriede
  Date: 2003-12-01 16:24
  Summary: osst, the Linux OnStream Tape driver now avalable on sf.net

  Following the unfortunate bankruptcy of OnStream, I have now completed
  the migration of the osst CVS repository, web site and mailing list to
  SourceForge.

  Willem Riede,
  osst maintainer.

How does this relate to your removal of onstream from 2.6?  I'm guessing
that you are maintaining onstream in 2.4, but not in 2.6 or beyond.  But
that's just a guess.

With onstream tape cartridges selling for (another guess - can't
actually _find_ any for sale anymore) at $4/Gbyte, and IDE drives at
under $1/Gbyte, using removable drives for backup makes more sense than
using onstream, anyway I can see to cut it.  And the chances of the IDE
interface going obsolete anytime soon seem refreshingly small.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373

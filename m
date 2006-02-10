Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932248AbWBJXf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932248AbWBJXf1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWBJXf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:35:26 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2984 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932248AbWBJXf0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:35:26 -0500
Date: Sat, 11 Feb 2006 00:35:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@suspend2.net>, suspend2-devel@lists.suspend2.net,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060210233507.GC1952@elf.ucw.cz>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060209233406.GD3389@elf.ucw.cz> <200602101008.32368.nigel@suspend2.net> <200602101337.22078.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200602101337.22078.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

So another flamewar is over, good. I even received one apology ;-),
and probably should have sent some apologies, too...

Anyway, it means that suspend is still quite a hot topic, and that is
good. (Linus said that suspend-to-disk is basically for people that
can't get suspend-to-RAM to work, and after I got suspend-to-RAM to
work reliably here, I can see his point).

Anyway, uswsusp project needs your help. It is basically working, see
www.sf.net/projects/suspend , and it is already faster then in-kernel
version. How you could help?

* testing is useful at this point. Few confirmations that it works in
different configurations would make us feel warm and fuzzy. 

* documentation improvements, and small scripts. Having script that
prepares initrd would be nice, for example. 

* having someone to maintain suspend.sf.net web pages / release CVS
snapshot as package would help, too.

* userspace code improvements. Encryption, LZW and graphical progress
should be reasonably easy to do. There's some tricky stuff, if you
prefer -- support for swap files and normal files would help,
too. Plus I guess everyone has their favourite feature...

								Pavel
-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...

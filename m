Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264070AbTDWOqM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264071AbTDWOqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:46:11 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:14302 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S264070AbTDWOqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:46:04 -0400
Date: Wed, 23 Apr 2003 10:44:27 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
Message-ID: <20030423144427.GM354@phunnypharm.org>
References: <20030423122940.51011.qmail@web14002.mail.yahoo.com> <20030423125315.GH820@hottah.alcove-fr> <20030423130139.GD354@phunnypharm.org> <20030423132227.GI820@hottah.alcove-fr> <20030423133256.GG354@phunnypharm.org> <20030423135814.GJ820@hottah.alcove-fr> <20030423135448.GI354@phunnypharm.org> <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030423145122.GL820@hottah.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I entirely agree.
> 
> However, the patch we are discussing has only *6 days*. If you had
> submitted it 2 months ago, there wouldn't be such problems.
> 
> [BTW: searching back the l-k archives doesn't find any occurances of
> your patch. I guess you sended it directly to Marcelo...]
> 
> > Then after a long huge pause, it suddenly goes -rc. Should that leave me
> > stuck? Don't think so.
> 
> Sure, you should continue development and submit a fresh new version
> ready to be tested in 2.4.22-pre1/pre2. 
> 
> As for 2.4.21, well, we want something pretty well tested. Will this
> be the case with your new mega-patch ? I don't think so. The safest
> is to go back to a version which worked. At least the bugs of that
> version are known, which is not the case for the new version.

Mega patch? I hardly call it a mega patch. It's mostly cleanups and it
was taken from an existing branch. Stuff that is already in Linus' tree.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

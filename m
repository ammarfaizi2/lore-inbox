Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbTDZOoA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 10:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbTDZOoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 10:44:00 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:61589 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261326AbTDZOn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 10:43:59 -0400
Date: Sat, 26 Apr 2003 10:40:18 -0400
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The IEEE-1394 saga continued... [ was: IEEE-1394 problem on init ]
Message-ID: <20030426144017.GD2774@phunnypharm.org>
References: <20030423142131.GK820@hottah.alcove-fr> <20030423142353.GL354@phunnypharm.org> <20030423145122.GL820@hottah.alcove-fr> <20030423144857.GN354@phunnypharm.org> <20030423152914.GM820@hottah.alcove-fr> <Pine.LNX.4.53L.0304231609230.5536@freak.distro.conectiva> <20030423202002.GA10567@vitel.alcove-fr> <20030423202453.GA354@phunnypharm.org> <20030423204258.GB10567@vitel.alcove-fr> <20030426082956.GB18917@vitel.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030426082956.GB18917@vitel.alcove-fr>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Since I reported issues about this 3 days ago, I would have appreciated
> being CC:'ed on the patch mail, so I could have reported issues 
> like this _before_ such a patch being applied. 

BTW, there are atleast 2 dozen people looking for this patch. I tested
it and several others on the linux1394 mailing list tested it. If you
want to be more closely involved with linux1394 specifically, then don't
expect me to search you out...come to us where our development happens.
We have a commit list to the repo and a developers list.

Things happen there...the only reason I bother the general linux-kernel
list is for things that affect outside the scope of drivers/ieee1394/*.
I don't think that's much different than a lot of projects in the
kernel.

I've never sent my patches to the list prior to inclusion in the kernel,
and a lot of folks don't, depending on neccessity. I don't see the need
to start now, not when interested parties have a place to go to see the
patches before hand anyway. Nothing major I send to Marcelo or Linus is
done so without it being committed in out repo first.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

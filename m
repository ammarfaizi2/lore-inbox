Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261746AbSJCQ6R>; Thu, 3 Oct 2002 12:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261740AbSJCQ6R>; Thu, 3 Oct 2002 12:58:17 -0400
Received: from host145.south.iit.edu ([216.47.130.145]:39332 "EHLO
	lostlogicx.com") by vger.kernel.org with ESMTP id <S261746AbSJCQ6P>;
	Thu, 3 Oct 2002 12:58:15 -0400
Date: Thu, 3 Oct 2002 12:03:29 -0500
From: Brandon Low <lostlogic@gentoo.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O(1) scheduler for 2.4.(19|20-pre.)?
Message-ID: <20021003120329.H6891@lostlogicx.com>
References: <200210031148.23823.roy@karlsbakk.net> <1033647544.28022.2.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1033647544.28022.2.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 03, 2002 at 01:19:04PM +0100
X-Operating-System: Linux found 2.4.19-gentoo-r9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.19-ac/2.4.20-ac, Red Hat 7.3, Red Hat 8.0, and probably quite a few
> other places. I think Robert had a set of patches versus plain 2.4.19
> too

Unfortunately some of the scheduler bits that have been merged into 
2.4.20-pre have broken the nice patch that robert has, I'm hoping he can 
re-diff it for us (me) because I like to have the option of getting O(1) 
without using Alan's tree.

Good luck.

Brandon Low
Gentoo Linux Kernel Release Coordinator

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVAOB41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVAOB41 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 20:56:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVAOBs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 20:48:56 -0500
Received: from [81.2.110.250] ([81.2.110.250]:58857 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262136AbVAOBp1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 20:45:27 -0500
Subject: Re: thoughts on kernel security issues
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Dave Jones <davej@redhat.com>, Marek Habersack <grendel@caudium.net>,
       Chris Wright <chrisw@osdl.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Greg KH <greg@kroah.com>,
       akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0501140020470.2867@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.58.0501121148240.2310@ppc970.osdl.org>
	 <20050112174203.GA691@logos.cnet>
	 <1105627541.4624.24.camel@localhost.localdomain>
	 <20050113194246.GC24970@beowulf.thanes.org>
	 <20050113115004.Z24171@build.pdx.osdl.net>
	 <20050113202905.GD24970@beowulf.thanes.org>
	 <1105645267.4644.112.camel@localhost.localdomain>
	 <20050113210229.GG24970@beowulf.thanes.org>
	 <20050113213002.GI3555@redhat.com>
	 <20050113214814.GA9481@beowulf.thanes.org>
	 <20050113220652.GJ3555@redhat.com>
	 <Pine.LNX.4.61.0501140020470.2867@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105748095.9838.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sat, 15 Jan 2005 00:34:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-13 at 23:30, Jesper Juhl wrote:
> The users are still vulnerable during the time you are preparing your 
> kernel packages.

Vulnerable to what - a bug that has probably taken months to be located
and isn't know to the bad guys right now ?

> proper fix is being developed.  I can't do that if I'm in the dark until 
> vendors feel comfortable and ready to release packaged bug free kernels - 
> and all the time I'm waiting some black hat idiot may have found the same 
> bug and cracked my system.

Let me save you some hassle. On current models anything you are running
more than 5000 lines long probably has serious flaws in it. Your
processor probably has flaws too, and even if you put up your firewall
someone might break into your house with a sledgehammer and take your
computer away (eg the music industry ;))

Its also about -risk- levels and the sum of risk to all parties
involved.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUHVXDw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUHVXDw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 19:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267730AbUHVXDw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 19:03:52 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:63250 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S267664AbUHVXDj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 19:03:39 -0400
Date: Mon, 23 Aug 2004 00:03:36 +0100
From: John Levon <levon@movementarian.org>
To: Tomasz K?oczko <kloczek@rudy.mif.pg.gda.pl>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Julien Oster <usenet-20040502@usenet.frodoid.org>,
       Miles Lane <miles.lane@comcast.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: DTrace-like analysis possible with future Linux kernels?
Message-ID: <20040822230336.GA2664@compsoc.man.ac.uk>
References: <200408191822.48297.miles.lane@comcast.net> <87hdqyogp4.fsf@killer.ninja.frodoid.org> <Pine.LNX.4.60L.0408210520380.3003@rudy.mif.pg.gda.pl> <1093174557.24319.55.camel@localhost.localdomain> <Pine.LNX.4.60L.0408221845450.3003@rudy.mif.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60L.0408221845450.3003@rudy.mif.pg.gda.pl>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1Bz1NA-00056H-B8*GXv7FrtMb82*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 22, 2004 at 08:27:38PM +0200, Tomasz K?oczko wrote:

> As same as KProbe/DTrace. Can you use OProfile for something other tnan 
> profiling ? Probably yes and this answer opens: probably it will be good 
> prepare some common code for KProbe and Oprofile.

I don't see an overlap here, except maybe the possibility of delivering
sample events into the kprobes framework

> It is not only extenging entropy kernel tree. IMO KProbe can bring some
> functionalities wich can be common also for OProfile and probably in 
> future IMO OProfile can be droped.

This seems extremely unlikely to say the least, compare the methods
used.

regards
john

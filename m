Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbTJALwv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 07:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbTJALwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 07:52:51 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:26126 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262064AbTJALwu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 07:52:50 -0400
Date: Wed, 1 Oct 2003 12:52:48 +0100
From: John Levon <levon@movementarian.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       perfctr-devel@lists.sourceforge.net, albert@users.sourceforge.net
Subject: Re: Who changed /proc/<pid>/ in 2.6.0-test5-bk9?
Message-ID: <20031001115248.GC23819@compsoc.man.ac.uk>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <16250.38688.152166.875893@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16250.38688.152166.875893@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A4fXE-0009tk-Tl*HUS/SSV/dRY*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 01, 2003 at 10:58:08AM +0200, Mikael Pettersson wrote:

> Linus' 2.6.0-test6 announcement doesn't seem to mention the
> fact that 2.6.0-test5-bk9 fundamentally changed the semantics
> of /proc/self and the /proc/<pid> name space. These used to

Are these Albert Calahan's changes ?

For some reason I can't fathom they were sent privately to Linus without
them first being posted publicly anywhere ...

john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.

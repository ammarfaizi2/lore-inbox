Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313898AbSHFRXL>; Tue, 6 Aug 2002 13:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314096AbSHFRXL>; Tue, 6 Aug 2002 13:23:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25295 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313898AbSHFRXK>;
	Tue, 6 Aug 2002 13:23:10 -0400
Date: Tue, 06 Aug 2002 10:13:08 -0700 (PDT)
Message-Id: <20020806.101308.30924385.davem@redhat.com>
To: jt@hpl.hp.com, jt@bougret.hpl.hp.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk
Subject: Re: Linux 2.4.20-pre1
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020806171736.GC11313@bougret.hpl.hp.com>
References: <20020806002126.GA10585@bougret.hpl.hp.com>
	<Pine.LNX.4.44.0208060933070.7302-100000@freak.distro.conectiva>
	<20020806171736.GC11313@bougret.hpl.hp.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
   Date: Tue, 6 Aug 2002 10:17:36 -0700
   
   	The second thing that bugs me is that because those patches
   pass behind my back, they won't get applied to *both* 2.4.X and
   2.5.X. Because of that, keeping 2.4.X and 2.5.X in synch is an
   exercise in futility.

This is an old topic.  If cleanups get submitted they are going
to go in.  If this means that someone has to redo a patch, that
is just a part of life.

Nobody is "above the law", sort of speak, when it comes to these
things.  Cleanups and compile warning fixes are not required to
go through the maintainer of a piece of code.

About IRDA wrt. 2.4.x vs 2.5.x, it requires a partial rewrite in 2.5.x
anyways so don't get worked up over it :)

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315491AbSGNAjh>; Sat, 13 Jul 2002 20:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315503AbSGNAjg>; Sat, 13 Jul 2002 20:39:36 -0400
Received: from codepoet.org ([166.70.99.138]:55777 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S315491AbSGNAje>;
	Sat, 13 Jul 2002 20:39:34 -0400
Date: Sat, 13 Jul 2002 18:42:28 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: c0330 <c0330@yingwa.edu.hk>, linux-kernel@vger.kernel.org
Subject: Re: Future of Kernel tree 2.0 ............
Message-ID: <20020714004227.GE29007@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	c0330 <c0330@yingwa.edu.hk>, linux-kernel@vger.kernel.org
References: <E17TUXf-0000Ow-00@ited.yingwa.edu.hk> <200207131543.49094.roy@karlsbakk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200207131543.49094.roy@karlsbakk.net>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Jul 13, 2002 at 03:43:49PM +0200, Roy Sigurd Karlsbakk wrote:
> >   Will kernel tree 2.0 stop developing and regard historical after the
> > release of 2.6?  I think we would put our focus on much more newer kernel.
> > And I found this may confuse the newbies, because they don't know much
> > about versioning in Kernel.
> >
> >   In nowsdays, there are less less compputers using 2.0. We should push
> > them to upgrade, so I think stop developing 2.0 is better, in my opinion
> 
> Is there any reason at all to use 2.0 instead of 2.2?

Size.  I recall putting together an mmu-less system running a
2.0.x kernel.  For the first rev of the board I had just 1 MB
of ram.  Try doing that with 2.4.x....  doesn't work.

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--

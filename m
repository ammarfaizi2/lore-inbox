Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316594AbSFUO12>; Fri, 21 Jun 2002 10:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316619AbSFUO11>; Fri, 21 Jun 2002 10:27:27 -0400
Received: from splat.lanl.gov ([128.165.17.254]:44675 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S316594AbSFUO10>; Fri, 21 Jun 2002 10:27:26 -0400
Date: Fri, 21 Jun 2002 08:27:26 -0600
From: Eric Weigle <ehw@lanl.gov>
To: Hayden James <hjames@stevens-tech.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CML2
Message-ID: <20020621142726.GF24131@lanl.gov>
References: <Pine.SGI.4.30.0206202040260.8750970-100000@attila.stevens-tech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SGI.4.30.0206202040260.8750970-100000@attila.stevens-tech.edu>
User-Agent: Mutt/1.3.28i
X-Eric-Conspiracy: There is no conspiracy
X-Editor: Vim, http://www.vim.org
X-GnuPG-fingerprint: 112E F8CA 12A9 771E DB10  6514 D4B0 D758 59EA 9C4F
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has it been decided not to put in CML2 into 2.5.x?  I haven't seen much
> talk of it (besides the patch being taken out of kbuild 2.5 and ESR
> dropping off the list).  Also I have not seen any word of it on Guillaume
> Boissiere's 2.5 kernel status page.  I had thought that and the new kbuild
> (by Keith Owens) were suppose to be in the kernel since 2.5.1.
OOoooh, ouch. You apparently missed the two (or more) significant flamewars
on these topics. The current status is that kbuild will probably slowly be
merged by going through Kai and being munged into Linus-acceptable patches,
while CML2 will probably sit around and never get merged unless ESR accepts
the fact that cool code solving a problem doesn't automagically get into
the kernel.

See the thread rooted somewhere around here ("Disgusted with Kbuild..."):
	http://www.uwsg.iu.edu/hypermail/linux/kernel/0202.2/0000.html

-Eric

-- 
------------------------------------------------
 Eric H. Weigle -- http://public.lanl.gov/ehw/ 
------------------------------------------------

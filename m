Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311917AbSDCV2n>; Wed, 3 Apr 2002 16:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312235AbSDCV2c>; Wed, 3 Apr 2002 16:28:32 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:13722 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S311917AbSDCV2R>;
	Wed, 3 Apr 2002 16:28:17 -0500
Date: Wed, 3 Apr 2002 16:28:06 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Schwartz <davids@webmaster.com>, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>,
        Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
Message-ID: <20020403162806.A20151@nevyn.them.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	David Schwartz <davids@webmaster.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	Arjan van de Ven <arjanv@redhat.com>,
	Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
	Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020403210754.AAA22091@shell.webmaster.com@whenever> <E16ssNa-0004ZV-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 03, 2002 at 10:33:18PM +0100, Alan Cox wrote:
> > allow other people to use and modify it. You can't have it both ways -- 
> > there's no such thing as 'GPL but with a few extra restrictions I've added to 
> > the code that everyone's contributed to'.
> 
> Nor is there "GPL with a few things ignored". 

Sure there is.  I don't think the kernel's under one, though.  They're
all over the place:  For instance, the libgcc license is "GPL except
anything can use it if compiled with GCC".  Various SSL-using programs
are distributed under "GPL but you can link it to OpenSSL anyway".

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287373AbSBGWTH>; Thu, 7 Feb 2002 17:19:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291122AbSBGWSs>; Thu, 7 Feb 2002 17:18:48 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:55648 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S287373AbSBGWSl>; Thu, 7 Feb 2002 17:18:41 -0500
Date: Thu, 7 Feb 2002 23:19:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Andrew Morton <akpm@zip.com.au>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] VM_IO fixes
Message-ID: <20020207231942.T1743@athlon.random>
In-Reply-To: <3C621B44.10C424B9@zip.com.au> <Pine.LNX.4.33.0202072204150.6350-100000@dbl.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0202072204150.6350-100000@dbl.localdomain>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 10:34:10PM +0100, Manfred Spraul wrote:
> On Wed, 6 Feb 2002, Andrew Morton wrote:
> > This patch doesn't fix the PTRACE_PEEKUSR bug - for that we need
> > this patch as well as the patch Andrea, Manfred and I pieced
> > together - it's at http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.18pre7aa2/00_get_user_pages-2
> > I understand that Manfred will be sending you a version of that patch.
> > 
> My patch is below.
> The only difference between my and Andrea's version is one indentation and 
> a new comment that warns about possible cache coherency problems.

Fine, thanks.

Andrea

Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316366AbSEOKRz>; Wed, 15 May 2002 06:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316367AbSEOKRy>; Wed, 15 May 2002 06:17:54 -0400
Received: from [195.39.17.254] ([195.39.17.254]:21911 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S316366AbSEOKRx>;
	Wed, 15 May 2002 06:17:53 -0400
Date: Wed, 15 May 2002 12:14:44 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Christoph Hellwig <hch@infradead.org>, Patricia Gaughen <gone@us.ibm.com>,
        marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] discontigmem support for ia32 NUMA box against 2.4.19pre8
Message-ID: <20020515101444.GB1152@elf.ucw.cz>
In-Reply-To: <200205090019.g490JXY17324@w-gaughen.des.beaverton.ibm.com> <20020509102801.A9548@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Please consider this patch for inclusion into the next 2.4 release.
> > Sent this patch out last week as an RFC.  I've resolved the comments 
> > from that post, mostly regarding config options.  
> 
> I think this patch, unlike the two previous cleanups, still needs some
> polishing.
> 
> > http://prdownloads.sourceforge.net/lse/meminit-2.4.19pre8.patch
> > http://prdownloads.sourceforge.net/lse/setup_arch-2.4.19pre8.patch
> > The discontigmem patch is available at:
> > 
> > http://prdownloads.sourceforge.net/lse/x86_discontigmem-2.4.19pre8.patch
> 
> Urgg, sourceforge seems to have turned these nice links into some download
> selector crap.  I think it's really time to stop using it as it gets worse
> all time..
> Any chance you could post links directly to one of the mirrors next
> time?

Heh, and you have not seen advertisments being added to mailing lists
:-(.

									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa

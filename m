Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262341AbVEYNeC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262341AbVEYNeC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 09:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbVEYNcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 09:32:19 -0400
Received: from fire.osdl.org ([65.172.181.4]:53425 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262341AbVEYNa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 09:30:27 -0400
Date: Wed, 25 May 2005 06:29:38 -0700
From: Chris Wright <chrisw@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Chris Wright <chrisw@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-stable <stable@kernel.org>, Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
       Daniel Drake <dsd@gentoo.org>
Subject: Re: [patch 07/16] ide-disk: Fix LBA8 DMA
Message-ID: <20050525132938.GI27549@shell0.pdx.osdl.net>
References: <200505250514_MC3-1-9FB4-C35C@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505250514_MC3-1-9FB4-C35C@compuserve.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Chuck Ebbert (76306.1226@compuserve.com) wrote:
> > > +               else
> > > +                       lba48 = 0;
> > 
> >    ^^^^^^^^^^^^^^^^^^^^^^^
> > 
> >   Spaces instead of tabs?
> 
>   But the patch really does seem to be tabdamaged...
> 

Yes, I'll refresh, thanks.
-chris

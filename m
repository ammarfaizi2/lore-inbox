Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291475AbSBSRbe>; Tue, 19 Feb 2002 12:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291520AbSBSRbY>; Tue, 19 Feb 2002 12:31:24 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:49422 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S291475AbSBSRbI>;
	Tue, 19 Feb 2002 12:31:08 -0500
Date: Tue, 19 Feb 2002 14:30:43 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [PATCH *] new struct page shrinkage
In-Reply-To: <3C7278B7.C0E4D126@mandrakesoft.com>
Message-ID: <Pine.LNX.4.33L.0202191429420.7820-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Jeff Garzik wrote:
> Rik van Riel wrote:
> > I've also pulled the thing up to
> > your latest changes from linux.bkbits.net so you should be
> > able to just pull it into your tree from:
>
> Note that with BK, unlike CVS, it is not required that you update to
> the latest Linus tree before he can pull.
>
> It is only desired that you do so if there is an actual conflict you
> need to resolve...

In this case there were 2 files with a potential conflict
(buffer.c and filemap.c).

No actual conflicts, but I thought it good manners to
pull the tree and resolve any potential conflicts myself,
instead of burdening Linus with the job.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


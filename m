Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268340AbTBSKer>; Wed, 19 Feb 2003 05:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268341AbTBSKer>; Wed, 19 Feb 2003 05:34:47 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:9661 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S268340AbTBSKeq>; Wed, 19 Feb 2003 05:34:46 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, Thomas Molina <tmolina@cox.net>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 19 Feb 2003 02:43:48 -0800 (PST)
Subject: Re: openbkweb-0.0
In-Reply-To: <20030219095701.GB14633@x30.suse.de>
Message-ID: <Pine.LNX.4.44.0302190240120.8609-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, Andrea Arcangeli wrote:

> On Sat, Feb 15, 2003 at 01:31:16PM -0800, David Lang wrote:
> > Andrea, since the on-disk format for bitkeeper is supposed to be SCCS
> > would it be good enough for you to be able to get a copy of this? what
> > mechanism would you prefer to use to get updates (rsync, FTP, HTTP, etc)
>
> how do you avoid races with rsync/ftp/http? How do you fetch the SCCS
> format out of bkbits.net w/o using bitkeeper?
>
> Andrea

I don't know the RIGHT answer about the races (quick and dirty answer,
deep doing a rsync until there is nothing to get???)

as far as getting the SCCS format the idea is that someone who uses
bitkeeper pulls a copy from bkbits.net and then makes the SCCS formal
available via the other methods (after I sent you the question above Rik
posted that he is doing this with ftp (for patches) and rsync (full SCCS
format).

David Lang

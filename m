Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317341AbSFLDcC>; Tue, 11 Jun 2002 23:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317344AbSFLDcB>; Tue, 11 Jun 2002 23:32:01 -0400
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:42372 "EHLO
	completely") by vger.kernel.org with ESMTP id <S317341AbSFLDbX>;
	Tue, 11 Jun 2002 23:31:23 -0400
From: Ryan Cumming <ryan@completely.kicks-ass.org>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] tmpfs 2/4 mknod times
Date: Tue, 11 Jun 2002 20:31:20 -0700
User-Agent: KMail/1.4.5
In-Reply-To: <Pine.LNX.4.21.0206120423200.1290-100000@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200206112031.23257.ryan@completely.kicks-ass.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On June 11, 2002 20:25, Hugh Dickins wrote:
> On Tue, 11 Jun 2002, Ryan Cumming wrote:
> > On June 11, 2002 19:54, Hugh Dickins wrote:
> > > +               dir->i_ctime = dir->i_mtime = CURRENT_TIME;
> >
> > I'm probably misreading this, but why does shmem_mknod modify the
> > directory's ctime?
>
> Hmmm, good question.  Perhaps I'll have dreamt up an answer by morning.
Well, lets see if the list has any ideas while you're sleeping.

- -Ryan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9BsCLLGMzRzbJfbQRAic3AJ9hh76od28Ic5OzB2PU8hLsV5vogACfbITB
8FyDd6i5BeMtk3xLzt1Y5ns=
=7+h9
-----END PGP SIGNATURE-----

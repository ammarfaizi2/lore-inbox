Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281812AbRLDAVL>; Mon, 3 Dec 2001 19:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284649AbRLDAOi>; Mon, 3 Dec 2001 19:14:38 -0500
Received: from sunspot.csun.edu ([130.166.114.30]:49162 "HELO sunspot.csun.edu")
	by vger.kernel.org with SMTP id <S284984AbRLCTKd>;
	Mon, 3 Dec 2001 14:10:33 -0500
Date: Mon, 3 Dec 2001 11:10:31 -0800 (PST)
From: Stephen Walton <swalton@sunspot.csun.edu>
Reply-To: <swalton@sunspot.csun.edu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Steffen Persvold <sp@scali.no>, lkml <linux-kernel@vger.kernel.org>,
        nfs list <nfs@lists.sourceforge.net>,
        <ext2-devel@lists.sourceforge.net>
Subject: Re: [NFS] Re: 2.4.9 kernel crash
In-Reply-To: <3C07E905.DF30E497@zip.com.au>
Message-ID: <Pine.LNX.4.33.0112031108470.14786-100000@sunspot.csun.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry for the long list of CC's but I wasn't sure which to delete.]

> There was a bug in ext3 which was fixed around about the 2.4.9
> timeframe.  I don't know if the fix is present in that
> particular Red Hat kernel.  It was fixed in ext3 0.9.8.

According to /usr/include/linux/ext3_fs.h, the redhat 2.4.9-13 kernel is
running ext3 0.9.11.  I've had no trouble with my NFS-exported ext3 disks.

--
Stephen Walton, Professor of Physics and Astronomy,
California State University, Northridge
stephen.walton@csun.edu


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315232AbSD2XBW>; Mon, 29 Apr 2002 19:01:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315233AbSD2XBV>; Mon, 29 Apr 2002 19:01:21 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:64435 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315232AbSD2XBU>; Mon, 29 Apr 2002 19:01:20 -0400
Date: Mon, 29 Apr 2002 16:03:30 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>
cc: Hanna V Linder <hannal@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] Re: 2.5.11 breakage
Message-ID: <31990000.1020121410@w-hlinder.des>
In-Reply-To: <Pine.GSO.4.21.0204291806280.5397-100000@weyl.math.psu.edu>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, April 29, 2002 18:18:44 -0400 Alexander Viro <viro@math.psu.edu> wrote:

> *	dentry leak is plugged
	
Thanks. I have verified the busy inodes problem is fixed. I was working 
on a fix, but yours is better.

Testing results on the way.

Hanna


Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317191AbSEXRGu>; Fri, 24 May 2002 13:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317199AbSEXRGt>; Fri, 24 May 2002 13:06:49 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36276 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S317191AbSEXRGt>;
	Fri, 24 May 2002 13:06:49 -0400
Date: Fri, 24 May 2002 13:06:49 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: negative dentries wasting ram
In-Reply-To: <Pine.GSO.4.21.0205241300480.9792-100000@weyl.math.psu.edu>
Message-ID: <Pine.GSO.4.21.0205241306080.9792-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 24 May 2002, Alexander Viro wrote:

> takes (hashed) dentry as an argument, so if unlinked on had 
                                                       ^^
                                                       one
sorry.


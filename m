Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277111AbRJDQ34>; Thu, 4 Oct 2001 12:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRJDQ3r>; Thu, 4 Oct 2001 12:29:47 -0400
Received: from zok.sgi.com ([204.94.215.101]:37589 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S277111AbRJDQ3j>;
	Thu, 4 Oct 2001 12:29:39 -0400
Date: Thu, 4 Oct 2001 11:30:00 -0500
From: Nathan Straz <nstraz@sgi.com>
To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
Message-ID: <20011004113000.A1458@sgi.com>
Mail-Followup-To: "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 03, 2001 at 02:00:35PM +0200, sebastien.cabaniols wrote:
> With the availability of XFS,JFS,ext3 and ReiserFS I am a little lost
> and I don't know which one I should use for entreprise class servers.

I'd recommend reading:

       http://www.mandrakeforum.com/article.php?sid=1212&lang=en

It's an article in the Mandrake forums concerning ext3, JFS, XFS, and
ReiserFS, all of which are in Mandrake 8.1.


> In terms of intergration into the kernel, functionnalities, stability
> and performance which one is the best for entreprise class servers

For enterprise stuff, I would recommend XFS based on the tools it
provides.  XFS has a complete set of tools for dumping XFS, repairing a
broken file system (should it every break), and debugging should you
find something wrong with it.  

-- 
Nate Straz                                              nstraz@sgi.com
sgi, inc                                           http://www.sgi.com/
Linux Test Project                                  http://ltp.sf.net/

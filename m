Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277190AbRJDRVN>; Thu, 4 Oct 2001 13:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277189AbRJDRVD>; Thu, 4 Oct 2001 13:21:03 -0400
Received: from fep02-0.kolumbus.fi ([193.229.0.44]:39896 "EHLO
	fep02-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S277185AbRJDRU6>; Thu, 4 Oct 2001 13:20:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Hristo Grigorov <Hristo.Grigorov@Kolumbus.FI>
To: Nathan Straz <nstraz@sgi.com>,
        "sebastien.cabaniols" <sebastien.cabaniols@laposte.net>
Subject: Re: [POT] Which journalised filesystem uses Linus Torvalds ?
Date: Thu, 4 Oct 2001 20:21:25 +0300
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <GKMPCZ$IZh2dKhbICnp0WDXKHB6iO7OKoHwqOxmqj9XfriOC7PjHiIDA6bHi6xrImT@laposte.net> <20011004113000.A1458@sgi.com>
In-Reply-To: <20011004113000.A1458@sgi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011004172126.OYMR26796.fep02-app.kolumbus.fi@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heh..

Choosing the best FS is like choosing the best Linux distribution or choosing
the best women for the rest of your life, as you like.. :) 

Each FS implementation has its strengths and weaknesses. I read that article
and come to the opinion that every peace of software is more or less PnP 
(plug-n-pray). You know, every code has bugs and the worst of them are never
found :)

Hristo.

On Thursday 04 October 2001 19:30, Nathan Straz wrote:
> On Wed, Oct 03, 2001 at 02:00:35PM +0200, sebastien.cabaniols wrote:
> > With the availability of XFS,JFS,ext3 and ReiserFS I am a little lost
> > and I don't know which one I should use for entreprise class servers.
>
> I'd recommend reading:
>
>        http://www.mandrakeforum.com/article.php?sid=1212&lang=en
>
> It's an article in the Mandrake forums concerning ext3, JFS, XFS, and
> ReiserFS, all of which are in Mandrake 8.1.
>
> > In terms of intergration into the kernel, functionnalities, stability
> > and performance which one is the best for entreprise class servers
>
> For enterprise stuff, I would recommend XFS based on the tools it
> provides.  XFS has a complete set of tools for dumping XFS, repairing a
> broken file system (should it every break), and debugging should you
> find something wrong with it.



Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274179AbRIXV61>; Mon, 24 Sep 2001 17:58:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274183AbRIXV6T>; Mon, 24 Sep 2001 17:58:19 -0400
Received: from pc-62-30-67-185-az.blueyonder.co.uk ([62.30.67.185]:26862 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S274165AbRIXV6G>; Mon, 24 Sep 2001 17:58:06 -0400
Date: Mon, 24 Sep 2001 22:57:47 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Chris Meadors <clubneon@hereintown.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.10 + ext3
Message-ID: <20010924225747.E9688@kushida.jlokier.co.uk>
In-Reply-To: <20010924204946.C9688@kushida.jlokier.co.uk> <Pine.LNX.4.40.0109241621100.12894-100000@rc.priv.hereintown.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.40.0109241621100.12894-100000@rc.priv.hereintown.net>; from clubneon@hereintown.net on Mon, Sep 24, 2001 at 04:22:13PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Meadors wrote:
> > I did have a big disaster once when I compiled ext3 into a kernel and
> > not ext2 (which I left as a module).  You can guess, it couldn't mount
> > the root filesystem.
> 
> What exactly did you do?  I have several machines that only have ext3
> compiled in, no ext2 at all, module or otherwise.  They all boot fine.

So do mine.  I had forgotten to convert the root filesystem, that's all.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264984AbTBTPBG>; Thu, 20 Feb 2003 10:01:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTBTPBG>; Thu, 20 Feb 2003 10:01:06 -0500
Received: from jurassic.park.msu.ru ([195.208.223.243]:42245 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S264984AbTBTPBF>; Thu, 20 Feb 2003 10:01:05 -0500
Date: Thu, 20 Feb 2003 18:10:27 +0300
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBdev updates.
Message-ID: <20030220181027.A9625@jurassic.park.msu.ru>
References: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0302200108090.20350-100000@phoenix.infradead.org>; from jsimmons@infradead.org on Thu, Feb 20, 2003 at 01:09:33AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 01:09:33AM +0000, James Simmons wrote:
> <jsimmons@maxwell.earthlink.net> (03/02/19 1.913.1.1)
...
> using standard macros for vgacon.c.

Unfortunately, this makes vgacon on non-legacy platforms where
the I/O port address doesn't fit in unsigned short almost
unfixable. :-(

Ivan.

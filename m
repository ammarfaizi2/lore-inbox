Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265087AbSJaB2O>; Wed, 30 Oct 2002 20:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265088AbSJaB2N>; Wed, 30 Oct 2002 20:28:13 -0500
Received: from vitelus.com ([64.81.243.207]:45829 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S265087AbSJaB2N>;
	Wed, 30 Oct 2002 20:28:13 -0500
Date: Wed, 30 Oct 2002 17:34:36 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.5.45
Message-ID: <20021031013436.GG23438@vitelus.com>
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 04:56:29PM -0800, Linus Torvalds wrote:
> 
> 
> Big changes, lots of merges. A number of the merges are fairly
> substantial too. 
> 
> Device mapper (LVM2), crypto/ipsec stuff for networking, epoll and giving
> the new kernel configurator a chance. Big things.

Now running 'make oldconfig' or 'make menuconfig' requires a Qt
installation. I believe that this is a bug because these still work
fine without Qt when the -k flag is passed to make.

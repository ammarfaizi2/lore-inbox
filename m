Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287017AbRL1Usa>; Fri, 28 Dec 2001 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287016AbRL1UsU>; Fri, 28 Dec 2001 15:48:20 -0500
Received: from pcow029o.blueyonder.co.uk ([195.188.53.123]:49938 "EHLO
	blueyonder.co.uk") by vger.kernel.org with ESMTP id <S287017AbRL1UsR>;
	Fri, 28 Dec 2001 15:48:17 -0500
Message-ID: <T581b9e8935ac1785e72b2@pcow029o.blueyonder.co.uk>
Content-Type: text/plain; charset=US-ASCII
From: James A Sutherland <james@sutherland.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, rhw@MemAlpha.cx
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Date: Fri, 28 Dec 2001 20:48:52 +0000
X-Mailer: KMail [version 1.3.1]
Cc: adilger@turbolabs.com (Andreas Dilger),
        alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <E16K23q-0001OG-00@the-village.bc.nu>
In-Reply-To: <E16K23q-0001OG-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 28 December 2001 6:48 pm, Alan Cox wrote:
> > currently is, but add a PATCHES-TO file in each subdirectory that
> > states how to handle patches relating to that directory, and have
> > these files follow a strict format, possibly...
>
> Add the patches to to the maintainers as another field. If the patches
> go to someone who isnt claiming to be a maintainer something is wrong

Except it seems maintainers is, er, unmaintained... Dave's/my solution looks 
good from this point of view, allowing others to "subscribe" to track patches 
to subsystems they care about. As well as allowing Al to remain a "closet 
maintainer", rather than putting him in maintainers :)


James.

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSKANEt>; Fri, 1 Nov 2002 08:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265015AbSKANEt>; Fri, 1 Nov 2002 08:04:49 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:20359 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265012AbSKANDr>; Fri, 1 Nov 2002 08:03:47 -0500
Subject: Re: What's left over.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
In-Reply-To: <3DC19A4C.40908@pobox.com>
References: <Pine.LNX.4.44.0210310918260.1410-100000@penguin.transmeta.com>
	 <3DC19A4C.40908@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 01 Nov 2002 13:30:18 +0000
Message-Id: <1036157418.12693.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-31 at 21:02, Jeff Garzik wrote:
> hosed/screaming, and various mid-layers are dying.  For LKCD to be of 
> any use, it needs to _skip_ the block layer and talk directly to 
> low-level drivers.

Rusty wrote a polled IDE driver that should handle some subset of that


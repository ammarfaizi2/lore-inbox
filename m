Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268132AbUIBLO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268132AbUIBLO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:14:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268191AbUIBLOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:14:17 -0400
Received: from mail1.kontent.de ([81.88.34.36]:53925 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264648AbUIBLLY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:11:24 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 2 Sep 2004 13:13:11 +0200
User-Agent: KMail/1.6.2
Cc: Jeremy Allison <jra@samba.org>, Jamie Lokier <jamie@shareable.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Rik van Riel <riel@redhat.com>,
       Christer Weinigel <christer@weinigel.se>, Spam <spam@tnonline.net>,
       Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       Linus Torvalds <torvalds@osdl.org>, reiser@namesys.com, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       flx@namesys.com, reiserfs-list@namesys.com
References: <Pine.LNX.4.44.0408261011410.27909-100000@chimarrao.boston.redhat.com> <20040901202641.GJ4455@legion.cup.hp.com> <1094118524.4842.27.camel@localhost.localdomain>
In-Reply-To: <1094118524.4842.27.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021313.11063.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 2. September 2004 11:48 schrieb Alan Cox:
> What I don't understand is the tie between Linux having such streams and
> Windows doing it for Samba to work. Netatalk has always handle this for
> Macintosh and portably. Presumably any Samba support would need to
> handle OS's without wacky files for portability too ?

Can you do an atomic rename of all streams without kernel support?

	Regards
		Oliver

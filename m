Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268053AbUIGNmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268053AbUIGNmk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 09:42:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268057AbUIGNmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 09:42:40 -0400
Received: from mail1.kontent.de ([81.88.34.36]:22172 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268053AbUIGNm2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 09:42:28 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: silent semantic changes with reiser4
Date: Tue, 7 Sep 2004 15:44:22 +0200
User-Agent: KMail/1.6.2
Cc: Christer Weinigel <christer@weinigel.se>,
       David Masover <ninja@slaphack.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>, Linus Torvalds <torvalds@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, Jamie Lokier <jamie@shareable.org>,
       Chris Wedgwood <cw@f00f.org>, viro@parcelfarce.linux.theplanet.co.uk,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
References: <200409070206.i8726vrG006493@localhost.localdomain> <m3d60yjnt7.fsf@zoo.weinigel.se> <20040907123011.GA18828@MAIL.13thfloor.at>
In-Reply-To: <20040907123011.GA18828@MAIL.13thfloor.at>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409071544.22439.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 7. September 2004 14:30 schrieb Herbert Poetzl:
> > 1. Do we want support for named streams?
> > 
> >    I belive the answer is yes, since both NTFS and HFS (that's the
> >    MacOS filesystem, isn't it?) supports streams we want Linux to
> >    support this if possible.
> 
> well, yes HFS has this, is it advantageous, no
> it's kind of heritage ...

HFS doesn't support _named_ streams. There are just two forks
per file.

	Regards
		Oliver

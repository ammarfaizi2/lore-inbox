Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267601AbUIGGCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267601AbUIGGCh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 02:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267598AbUIGGCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 02:02:37 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:11660 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S267594AbUIGGCf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 02:02:35 -0400
Message-ID: <413D4ED9.5090206@namesys.com>
Date: Mon, 06 Sep 2004 23:02:01 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Horst von Brand <vonbrand@inf.utfsm.cl>, Spam <spam@tnonline.net>,
       Tonnerre <tonnerre@thundrix.ch>,
       Christer Weinigel <christer@weinigel.se>,
       Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       Jamie Lokier <jamie@shareable.org>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
References: <200409070206.i8726vrG006493@localhost.localdomain> <413D4C18.6090501@slaphack.com>
In-Reply-To: <413D4C18.6090501@slaphack.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just want to remind that no one has been able to offer a good way of 
handling attributes/streams/metafiles other than reiser4 in which 
CTRL-XCTRL-Ffilename within emacs to edit the stream/attribute/metafile 
will work without modifying the emacs source.  David Masover is right 
that there are far more application writers than kernel hackers, and we 
should make the kernel more complicated if it makes a few thousand apps 
simpler.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269391AbUIBX6F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269391AbUIBX6F (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 19:58:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUIBX6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 19:58:01 -0400
Received: from the-village.bc.nu ([81.2.110.252]:12178 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S269391AbUIBXzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 19:55:04 -0400
Subject: Re: silent semantic changes with reiser4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, Lee Revell <rlrevell@joe-job.com>,
       Pavel Machek <pavel@ucw.cz>, Spam <spam@tnonline.net>,
       David Masover <ninja@slaphack.com>, Chris Wedgwood <cw@f00f.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <20040902232350.GA32244@mail.shareable.org>
References: <rlrevell@joe-job.com>
	 <1094155277.11364.92.camel@krustophenia.net>
	 <200409022200.i82M0ihC026321@laptop11.inf.utfsm.cl>
	 <20040902232350.GA32244@mail.shareable.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094165499.6170.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 23:51:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-03 at 00:23, Jamie Lokier wrote:
> However, if we ever see that search engine index thing happen, it
> would be a most excellent capability if it searched inside archive
> files too.  I would definitely use that.  Not often, but occasionally I would.

Thats an indexer decision, the search backend (which is the performance
and complexity critical part) doesn't give a damn.


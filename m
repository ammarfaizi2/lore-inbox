Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268968AbUICCOn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268968AbUICCOn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 22:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269427AbUICAMv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 20:12:51 -0400
Received: from c002781a.fit.bostream.se ([217.215.235.8]:33174 "EHLO
	mail.tnonline.net") by vger.kernel.org with ESMTP id S269419AbUICACY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 20:02:24 -0400
Date: Fri, 3 Sep 2004 02:02:10 +0200
From: Spam <spam@tnonline.net>
Reply-To: Spam <spam@tnonline.net>
X-Priority: 3 (Normal)
Message-ID: <1258629886.20040903020210@tnonline.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Lee Revell <rlrevell@joe-job.com>, Pavel Machek <pavel@ucw.cz>,
       David Masover <ninja@slaphack.com>, Chris Wedgwood <cw@f00f.org>,
       <viro@parcelfarce.linux.theplanet.co.uk>,
       Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       Hans Reiser <reiser@namesys.com>, <linux-fsdevel@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
In-Reply-To: <1094165499.6170.17.camel@localhost.localdomain>
References: <rlrevell@joe-job.com>
 <1094155277.11364.92.camel@krustophenia.net>
 <200409022200.i82M0ihC026321@laptop11.inf.utfsm.cl>
 <20040902232350.GA32244@mail.shareable.org>
 <1094165499.6170.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  

> On Gwe, 2004-09-03 at 00:23, Jamie Lokier wrote:
>> However, if we ever see that search engine index thing happen, it
>> would be a most excellent capability if it searched inside archive
>> files too.  I would definitely use that.  Not often, but occasionally I would.

> Thats an indexer decision, the search backend (which is the performance
> and complexity critical part) doesn't give a damn.

  I am just talking general now, but it seems to me that there have
  been many suggestions on user-land solutions like shared librares
  and so forth just to say there is no need for file streams and
  plugins. Many of these ideas do exist in one way or another, but
  none is truly system wide and and as application independent as 
  file streams+plugins would be. Would it not be much less effort to
  implement these in a good way, than trying to reinvent lots of new
  stuff in userland - that wouldn't be systemwide anyway?

  ~S

  


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268065AbUHZKJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268065AbUHZKJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 06:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHZKIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 06:08:06 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:59790 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268065AbUHZKGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 06:06:01 -0400
Date: Thu, 26 Aug 2004 03:05:30 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: viro@parcelfarce.linux.theplanet.co.uk, Linus Torvalds <torvalds@osdl.org>,
       Christoph Hellwig <hch@lst.de>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826100530.GA20805@taniwha.stupidest.org>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825200859.GA16345@lst.de> <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org> <20040825204240.GI21964@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408251348240.17766@ppc970.osdl.org> <20040825212518.GK21964@parcelfarce.linux.theplanet.co.uk> <20040826001152.GB23423@mail.shareable.org> <20040826003055.GO21964@parcelfarce.linux.theplanet.co.uk> <20040826010049.GA24731@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826010049.GA24731@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 02:00:49AM +0100, Jamie Lokier wrote:

> One of the big potential uses for file-as-directory is to go inside
> archive files, ELF files, .iso files and so on in a convenient way.

Arguably this belongs in userspace --- and people have put it there.


  --cw

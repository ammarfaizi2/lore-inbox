Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268609AbUHYUzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268609AbUHYUzY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 16:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268674AbUHYUzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 16:55:18 -0400
Received: from cantor.suse.de ([195.135.220.2]:64738 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268707AbUHYUvv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 16:51:51 -0400
Subject: Re: silent semantic changes with reiser4
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Nikita Danilov <Nikita@namesys.com>
In-Reply-To: <412CF96A.5040503@namesys.com>
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com>
	 <20040825200859.GA16345@lst.de>
	 <Pine.LNX.4.58.0408251314260.17766@ppc970.osdl.org>
	 <412CF96A.5040503@namesys.com>
Content-Type: text/plain
Message-Id: <1093467108.21878.240.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 16:51:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 16:41, Hans Reiser wrote:
> I just want to add that I AM capable of working with the other 
> filesystem developers in a team-player way, and I am happy to cooperate 
> with making portions more reusable where there is serious interest from 
> other filesystems in that, 

Prove it.  Stop replying for today and come back tomorrow with some
useful discussions.  Christoph suggested that some of the v4 semantics
belong in the VFS and therefore linux as a whole.  He's helping you to
make sure the semantics and fit nicely with the rest of kernel
interfaces and are race free.

Take him up on the offer.

-chris



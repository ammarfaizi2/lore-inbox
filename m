Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965405AbWJBV2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965405AbWJBV2x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 17:28:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965404AbWJBV2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 17:28:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965401AbWJBV2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 17:28:51 -0400
Date: Mon, 2 Oct 2006 14:28:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Olaf Hering <olaf@aepfle.de>
cc: Jens Axboe <axboe@kernel.dk>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] BLOCK: Fix linux/compat.h's use sigset_t
In-Reply-To: <Pine.LNX.4.64.0610021355330.3952@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0610021427550.3952@g5.osdl.org>
References: <20061002131231.19879.19860.stgit@warthog.cambridge.redhat.com>
 <20061002131234.19879.34671.stgit@warthog.cambridge.redhat.com>
 <20061002165137.GK5670@kernel.dk> <Pine.LNX.4.64.0610021004090.3952@g5.osdl.org>
 <20061002204055.GA18735@aepfle.de> <Pine.LNX.4.64.0610021355330.3952@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Linus Torvalds wrote:
> 
> Yeah, damn, I don't know what happened there. I fixed the patch, but then 
> actually applied the old version, it looks like.

Nope, I just messed up fixing the patch. Nothing to see here. I'm a 
maroon.

I checked in the missing line.

		Linus

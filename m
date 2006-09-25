Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWIYWzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWIYWzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWIYWzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:55:39 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17314 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751612AbWIYWzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:55:38 -0400
Date: Mon, 25 Sep 2006 15:55:34 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nomzomi: remove bogus cast
In-Reply-To: <1159223925.11049.160.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0609251552550.3952@g5.osdl.org>
References: <1159223925.11049.160.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Sep 2006, Alan Cox wrote:
>
> May as well go straight into the main tree

Umm. 

Great idea, but that file is not actually _in_ the main tree yet. I think 
your original patch to add it still lies in the -mm queue ;)

So send it to Andrew, or just re-send it once Andrew has patch-bombed me, 
ok? I'm too disorganized to keep track of it separately..

		Linus

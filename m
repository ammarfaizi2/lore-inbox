Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261923AbVAHIdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261923AbVAHIdo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 03:33:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261821AbVAHI05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 03:26:57 -0500
Received: from mproxy.gmail.com ([216.239.56.250]:32885 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261955AbVAHFuP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:50:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=fcQltHxEw5cMgskqOMH4iy7TKo0JEC1MwT2C6iinoXG5XGs4HQFKTLpB8NeBZWZdpo5a2IVejxA2lyhEPthG0PfJy6cPNLrM5izVJbkmj1z0ePPb8IdsJKbACJciubidG39WgKtXLjGbql1m0gRCbWqDWn6vDOTk+BuBrYTXlpQ=
Message-ID: <21d7e99705010721504365d373@mail.gmail.com>
Date: Sat, 8 Jan 2005 16:50:09 +1100
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: lindenting the drm directory..
Cc: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, jonsmirl@gmail.com
In-Reply-To: <20050107211002.3f86d325.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0501080411190.11556@skynet>
	 <20050107211002.3f86d325.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's probably best that you wait until the tree is in good shape and stable
> for a week or two before doing the big reformat because it will introduce a
> barrier over which patches may not pass in either direction.

well as most patches come via the CVS tree and myself it shouldn't be
too bad, the CVS tree has been Lindented for a couple of months so
I've been dealing with the issues myself as I pass the patches back
and forth...

Dave.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVAHFKX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVAHFKX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 00:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVAHFKX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 00:10:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:35981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261783AbVAHFKS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 00:10:18 -0500
Date: Fri, 7 Jan 2005 21:10:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, jonsmirl@gmail.com
Subject: Re: lindenting the drm directory..
Message-Id: <20050107211002.3f86d325.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501080411190.11556@skynet>
References: <Pine.LNX.4.58.0501080411190.11556@skynet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@linux.ie> wrote:
>
> the DRM is in a bad way with respect to whitespace, I know people have
>  objections to whitespace patches in bitkeeper, but after cleaning up all
>  the code, I'd like to Lindent it all as well, the DRM macro removal
>  touched every function in every file...
> 
>  as the DRM is developed in the CVS tree, and nearly all the blame
>  annotation in bitkeeper blames me I don't think it is really a bad thing
>  for the DRM...
> 
>  Objections?

Is up to you, really.  I doubt if you'll hear many objections to DRM macro
removal and whitespace cleanups.

It's probably best that you wait until the tree is in good shape and stable
for a week or two before doing the big reformat because it will introduce a
barrier over which patches may not pass in either direction.

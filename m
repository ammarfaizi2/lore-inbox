Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUDITBZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 15:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261654AbUDITBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 15:01:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:4031 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261631AbUDITBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 15:01:24 -0400
Date: Fri, 9 Apr 2004 12:01:06 -0700
From: Andrew Morton <akpm@osdl.org>
To: Dave Airlie <airlied@linux.ie>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: [patch] Trying to get DRM up to date in 2.6
Message-Id: <20040409120106.69e78838.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0404090838000.30863@skynet>
References: <Pine.LNX.4.58.0404090838000.30863@skynet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Airlie <airlied@linux.ie> wrote:
>
> In a first attempt to bring the DRM in 2.6 in line with the latest
>  developments in DRM CVS, I'm going to try and split the latest DRM stuff
>  up into patches and submit them,

Thanks.

>  I've setup a temporary BK repo at http://freedesktop.org:1234/drm-2.6/

Yes, that works.  Anything which you put into that bk tree will
automagically appear in my test kernels.  When we're happy with it you can
ask Linus to merge it into the top-level tree.

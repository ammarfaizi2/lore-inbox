Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932563AbWEVHLK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932563AbWEVHLK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 03:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932570AbWEVHLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 03:11:09 -0400
Received: from ns.suse.de ([195.135.220.2]:42452 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932563AbWEVHLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 03:11:08 -0400
Date: Mon, 22 May 2006 09:11:07 +0200
From: Olaf Hering <olh@suse.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: bboissin@gmail.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       sparclinux@vger.kernel.org
Subject: Re: [PATCH] implicit declaration of function `page_cache_release'
Message-ID: <20060522071107.GA7715@suse.de>
References: <40f323d00508051218c30d7af@mail.gmail.com> <20050806.065520.85401639.davem@davemloft.net> <20050806150103.GA21821@suse.de> <20050806.084950.74730249.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20050806.084950.74730249.davem@davemloft.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Sat, Aug 06, David S. Miller wrote:

> From: Olaf Hering <olh@suse.de>
> Date: Sat, 6 Aug 2005 17:01:03 +0200
> 
> > So the patch should be reverted? Its only for CONFIG_SWAP=n, rather
> > unusual for KDE/GNOME tainted workstations...
> 
> Not necessarily, but the header dependencies should be fixed
> up somehow.

I think you are right once again.
(Just the time got a bit out of sync.)

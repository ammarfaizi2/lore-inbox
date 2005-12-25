Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750915AbVLYUfh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbVLYUfh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Dec 2005 15:35:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750916AbVLYUfh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Dec 2005 15:35:37 -0500
Received: from mylar.outflux.net ([69.93.193.226]:24218 "EHLO
	mylar.outflux.net") by vger.kernel.org with ESMTP id S1750913AbVLYUfg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Dec 2005 15:35:36 -0500
Date: Sun, 25 Dec 2005 12:35:32 -0800
From: Kees Cook <kees@outflux.net>
To: James Lamanna <jlamanna@gmail.com>
Cc: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] lib: zlib_inflate "r.base" uninitialized compile warnings
Message-ID: <20051225203531.GN18040@outflux.net>
References: <aa4c40ff0512251208j46e5de99o51e8d18f5542e9a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa4c40ff0512251208j46e5de99o51e8d18f5542e9a2@mail.gmail.com>
X-HELO: ghostship.outflux.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 25, 2005 at 12:08:00PM -0800, James Lamanna wrote:
> What version of gcc are you using?

gcc (GCC) 4.0.3 20051201 (prerelease) (Debian 4.0.2-5)

> Looks like a gcc bug that was fixed?

I guess it's been introduced.  ;)

-- 
Kees Cook                                            @outflux.net

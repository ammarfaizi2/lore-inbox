Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266962AbSKWENS>; Fri, 22 Nov 2002 23:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266968AbSKWENS>; Fri, 22 Nov 2002 23:13:18 -0500
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:40337 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S266962AbSKWENR>;
	Fri, 22 Nov 2002 23:13:17 -0500
Date: Sat, 23 Nov 2002 04:22:18 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: New module loader makes kernel debugging much harder
Message-ID: <20021123042218.GA19835@bjl1.asuk.net>
References: <13542.1038018010@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13542.1038018010@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also "depmod" is now broken, so even with Rusty's replacement modutils
a system won't demand load modules properly.  Or is there a working
"depmod" and I missed it somewhere?

-- Jamie


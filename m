Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262346AbSJIXMA>; Wed, 9 Oct 2002 19:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262390AbSJIXMA>; Wed, 9 Oct 2002 19:12:00 -0400
Received: from bjl1.asuk.net.64.29.81.in-addr.arpa ([81.29.64.88]:50049 "EHLO
	bjl1.asuk.net") by vger.kernel.org with ESMTP id <S262346AbSJIXL7>;
	Wed, 9 Oct 2002 19:11:59 -0400
Date: Thu, 10 Oct 2002 00:17:31 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Robert Love <rml@tech9.net>, Marco Colombo <marco@esi.it>,
       linux-kernel@vger.kernel.org, akpm@digeo.com, riel@conectiva.com.br
Subject: Re: [PATCH] O_STREAMING - flag for optimal streaming I/O
Message-ID: <20021009231731.GB2654@bjl1.asuk.net>
References: <Pine.LNX.4.44.0210091606000.26363-100000@Megathlon.ESI> <1034172868.746.3707.camel@phantasy> <20021009152731.GY3045@clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021009152731.GY3045@clusterfs.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> I would say - if you are picking a new flag that doesn't need to have
> compatibility with any platform-specific existing flag, simply set them
> all high enough so that they are the same on all platforms.  Just
> because some of the flags are broken is no need to make all of them so.

Agreed!  It would have been nice to do this earlier as there are a few
flags in this category.  Oh well.

-- Jamie

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWBMHFB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWBMHFB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 02:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWBMHFB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 02:05:01 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:17681 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751078AbWBMHFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 02:05:00 -0500
Date: Mon, 13 Feb 2006 08:04:45 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Christoph Hellwig <hch@lst.de>
Cc: akpm@osdl.org, schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org,
       Horst Hummel <horst.hummel@de.ibm.com>,
       Stefan Weinhuber <wein@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>
Subject: Re: [PATCH 0/5] new dasd ioctl patchkit
Message-ID: <20060213070445.GA9345@osiris.boeblingen.de.ibm.com>
References: <20060212173843.GA26035@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060212173843.GA26035@lst.de>
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here's a new patchkit to fix the dasd ioctl mess, against
> 2.6.16-rc2-mm1.  I've built an s390 crosscompiler to compile-test them and
> I've booted the resulting kernel with a debian image in hercules (not that
> this excercises the ioctl path a whole lot, but I didn't find tools that
> actually used any of these ioctls).
> 
> The patches are also split more fine-grained than last time.

I leave it up to the dasd people (now on cc) to comment on your patches.

Thanks,
Heiko

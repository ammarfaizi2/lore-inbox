Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261207AbSIYXZH>; Wed, 25 Sep 2002 19:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSIYXZH>; Wed, 25 Sep 2002 19:25:07 -0400
Received: from thunk.org ([140.239.227.29]:21663 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261207AbSIYXZH>;
	Wed, 25 Sep 2002 19:25:07 -0400
Date: Wed, 25 Sep 2002 19:29:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] Add ext3 indexed directory (htree) support
Message-ID: <20020925232949.GA15765@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jeff Garzik <jgarzik@pobox.com>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E17uINs-0003bG-00@think.thunk.org> <3D923E88.30104@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D923E88.30104@pobox.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 25, 2002 at 06:54:00PM -0400, Jeff Garzik wrote:
> 
> Can you post a GNU patch too, for public lookover and independent 
> integration?
> 

Sure.  The patch is a bit big for e-mail, but you can find it at:

	http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.5.38

There is also a 2.4.19 patch available as well:

	http://thunk.org/tytso/linux/ext3-dxdir/patch-ext3-dxdir-2.4.19-2

							- Ted

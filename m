Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267021AbSLKFEa>; Wed, 11 Dec 2002 00:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267022AbSLKFEa>; Wed, 11 Dec 2002 00:04:30 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:21774 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267021AbSLKFE3>;
	Wed, 11 Dec 2002 00:04:29 -0500
Date: Tue, 10 Dec 2002 21:11:00 -0800
From: Greg KH <greg@kroah.com>
To: Wil Reichert <wilreichert@yahoo.com>
Cc: Andrew Morton <akpm@digeo.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: "bio too big" error
Message-ID: <20021211051100.GA13718@kroah.com>
References: <1039572597.459.82.camel@darwin> <3DF6A673.D406BC7F@digeo.com> <1039577938.388.9.camel@darwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039577938.388.9.camel@darwin>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 10:38:58PM -0500, Wil Reichert wrote:
> 
> I'm guessing its perhaps a 2.5 / lvm issue?  Here's 'vgdisplay -v' in
> case:

Did you try the dm patches that were just posted to lkml today?

thanks,

greg k-h

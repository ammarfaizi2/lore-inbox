Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbTDHWRp (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261977AbTDHWRp (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:17:45 -0400
Received: from granite.he.net ([216.218.226.66]:15118 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S261942AbTDHWRp (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:17:45 -0400
Date: Tue, 8 Apr 2003 14:51:45 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Christer Weinigel <wingel@nano-system.com>,
       linux-i2c@pelican.tk.uni-linz.ac.at, linux-kernel@vger.kernel.org,
       trivial@rustcorp.com.au
Subject: Re: [2.5 patch] fix drivers/i2c/scx200_i2c.c compilation
Message-ID: <20030408215145.GB6450@kroah.com>
References: <20030408113646.GE5046@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030408113646.GE5046@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 08, 2003 at 01:36:46PM +0200, Adrian Bunk wrote:
> I got the following compile error in 2.5.67:
> 
> <--  snip  -->

Thanks, I just added this to my tree yesterday :)
I'll send it on to Linus in a bit.

greg k-h

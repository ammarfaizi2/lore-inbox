Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265010AbTFURBq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 13:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbTFURBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 13:01:45 -0400
Received: from granite.he.net ([216.218.226.66]:3845 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265010AbTFURBp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 13:01:45 -0400
Date: Sat, 21 Jun 2003 10:01:51 -0700
From: Greg KH <greg@kroah.com>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: oliver@neukum.org, linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [2.5 patch] remove an unused label from kaweth.c
Message-ID: <20030621170151.GA18384@kroah.com>
References: <20030621150132.GB23337@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030621150132.GB23337@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 21, 2003 at 05:01:32PM +0200, Adrian Bunk wrote:
> Recent changes to kaweth added an unused label. The following patch 
> removes it.
> 
> I've tested the compilation with 2.5.72-mm2.

Thanks, I already have this fix in my USB tree, and will send it to
Linus in a few days.

thanks,

greg k-h

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265585AbTFMXus (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbTFMXus
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:50:48 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:4312 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265585AbTFMXur (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:50:47 -0400
Date: Fri, 13 Jun 2003 17:03:06 -0700
From: Greg KH <greg@kroah.com>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: ajoshi@kernel.crashing.org, James Simmons <jsimmons@infradead.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS] 2.5.70-bk15: RadeonFB dies at boot, and is undocumented
Message-ID: <20030614000306.GA2563@kroah.com>
References: <1055546532.1256.19.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1055546532.1256.19.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 13, 2003 at 04:22:13PM -0700, Torrey Hoffman wrote:
> With the Radeon framebuffer driver compiled in, 2.5.70-bk15 oopses very
> early during the boot process.  The oops is visible in text mode but
> scrolls off the screen.  (I really need to set up a serial console!)

Try a later -bk version, -bk17 fixes this I think, but to be safe, use
-bk18

thanks,

greg k-h

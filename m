Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268206AbUIKQsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268206AbUIKQsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 12:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268215AbUIKQsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 12:48:08 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:59401 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268206AbUIKQp5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 12:45:57 -0400
Date: Sat, 11 Sep 2004 17:45:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Mestnik <cheako911@yahoo.com>
Cc: Christoph Hellwig <hch@infradead.org>, Dave Airlie <airlied@linux.ie>,
       Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       =?iso-8859-1?Q?Felix=5FK=FChling?= <fxkuehl@gmx.de>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: radeon-pre-2
Message-ID: <20040911174552.B2956@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Mestnik <cheako911@yahoo.com>, Dave Airlie <airlied@linux.ie>,
	Jon Smirl <jonsmirl@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	=?iso-8859-1?Q?Felix=5FK=FChling?= <fxkuehl@gmx.de>,
	DRI Devel <dri-devel@lists.sourceforge.net>,
	lkml <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20040911132727.A1783@infradead.org> <20040911124930.98551.qmail@web11906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040911124930.98551.qmail@web11906.mail.yahoo.com>; from cheako911@yahoo.com on Sat, Sep 11, 2004 at 05:49:30AM -0700
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 11, 2004 at 05:49:30AM -0700, Mike Mestnik wrote:
> Not to step on toes, but...  From what I can tell the idea is to add code
> into FB that calles functions in the DRM and vice vers.  This would seam
> to  add another ABI.  Unless the code gets linked into one module, this
> idea has been flamed and killed already.

in-kernel ABIs are absolutely not an issue for Linux.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261304AbUKHXr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261304AbUKHXr3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 18:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbUKHXr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 18:47:29 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:20240 "EHLO pastinakel.tue.nl")
	by vger.kernel.org with ESMTP id S261304AbUKHXrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 18:47:25 -0500
Date: Tue, 9 Nov 2004 00:47:18 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, torvalds@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 docs
Message-ID: <20041108234718.GD2946@pclin040.win.tue.nl>
References: <20041108135541.GA23052@apps.cwi.nl> <20041108173007.GB2900@logos.cnet> <20041108210751.GA2946@pclin040.win.tue.nl> <20041108200703.GA3505@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041108200703.GA3505@logos.cnet>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: CollegeOfNewCaledonia: mailhost.tue.nl 1189; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2004 at 06:07:03PM -0200, Marcelo Tosatti wrote:

> > 14446 documents the EXT2_TOPDIR_FL flag that is undocumented
> > in the kernel source. The flag can be set using chattr +T.
> 
> PS: Maybe the flag should be documented? Its pretty important one.

Yes. Our conversation here provides for some documentation
since Google will be able to retrieve it. I added a line
in the table under "Attributes" in my old ext2 notes at
http://www.win.tue.nl/~aeb/linux/lk/lk-7.html#ss7.2
There is chattr(1). Someone searching will find something.

Andries

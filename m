Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267686AbSLGAvp>; Fri, 6 Dec 2002 19:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267689AbSLGAvp>; Fri, 6 Dec 2002 19:51:45 -0500
Received: from dp.samba.org ([66.70.73.150]:12207 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S267686AbSLGAvo>;
	Fri, 6 Dec 2002 19:51:44 -0500
Date: Sat, 7 Dec 2002 10:03:41 +1100
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] compatibility syscall layer - PPC64
Message-ID: <20021206230341.GA32556@krispykreme>
References: <20021204180224.406d143c.sfr@canb.auug.org.au> <20021204180729.22cf57c0.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021204180729.22cf57c0.sfr@canb.auug.org.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This is the PPC64 specific patch.  It goes slightly further than necessary
> by defining compat_size_t and compat_ssize_t.

Thanks Stephen, this has been merged and pulled into Linus-BK.

Anton

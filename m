Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbTCYV3p>; Tue, 25 Mar 2003 16:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261387AbTCYV3o>; Tue, 25 Mar 2003 16:29:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:59297 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261385AbTCYV3o>;
	Tue, 25 Mar 2003 16:29:44 -0500
Subject: Re: [TRIVIAL PATCH][2.5.66] fix for link-error in i810fb_imageblit
From: Andy Pfiffer <andyp@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: Russell King <rmk@arm.linux.org.uk>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303252049020.6228-100000@phoenix.infradead.org>
References: <Pine.LNX.4.44.0303252049020.6228-100000@phoenix.infradead.org>
Content-Type: text/plain
Organization: 
Message-Id: <1048628445.14000.10.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 25 Mar 2003 13:40:45 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 12:49, James Simmons wrote:
> > Why linux/fb.h and why asm/string.h when we have linux/string.h?
> > Shouldn't <linux/string.h> be included by the i810fb driver?
> 
> Done. I added linux/string.h to i810_accel.c.

Thanks.  Works for me. ;^)


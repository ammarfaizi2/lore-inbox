Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932088AbVHRBzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932088AbVHRBzX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 21:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbVHRBzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 21:55:23 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:60176 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932084AbVHRBzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 21:55:22 -0400
Date: Wed, 17 Aug 2005 21:55:01 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Jay Vosburgh <fubar@us.ibm.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 2.6.13-rc6] net/802/tr: use interrupt-safe locking
Message-ID: <20050818015459.GA20256@tuxdriver.com>
Mail-Followup-To: Jay Vosburgh <fubar@us.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <linville@tuxdriver.com> <20050817204959.GA20186@tuxdriver.com> <200508172148.j7HLmPAt005857@death.nxdomain.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508172148.j7HLmPAt005857@death.nxdomain.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2005 at 02:48:25PM -0700, Jay Vosburgh wrote:
> John W. Linville <linville@tuxdriver.com> wrote:

> >Signed-off-by: Jay Vosburg <foobar@us.ibm.com>
> 
> 	Pretty close.
> 
> Signed-off-by: Jay Vosburgh <fubar@us.ibm.com>

Ooops...sorry!  Tired, sloppy typing... :-(

> 	I believe that I originally wrote and posted this patch in the
> appended message; I recall posting it a few times in various places.

That is my understanding as well, which is why I put (an unfortunately
incorrect) S-o-b line for you ahead of mine.  Should I have done
something else?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com

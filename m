Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbTKEPTu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 10:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTKEPTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 10:19:50 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:60843 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S262941AbTKEPTt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 10:19:49 -0500
Date: Wed, 5 Nov 2003 07:19:41 -0800
From: Larry McVoy <lm@bitmover.com>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux.bkbits.net down?
Message-ID: <20031105151941.GA4195@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andrey Borzenkov  <arvidjaar@mail.ru>, linux-kernel@vger.kernel.org
References: <E1AHLUW-000OnO-00.arvidjaar-mail-ru@f10.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AHLUW-000OnO-00.arvidjaar-mail-ru@f10.mail.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bkbits is definitely up but we did switch T1 providers recently.
That included changing the routes in the backbone.  The only thing I can
think of is that your part of the backbone does not have a route for us.
We're 192.132.92.*, see if you can traceroute to us.

On Wed, Nov 05, 2003 at 02:06:24PM +0300, "Andrey Borzenkov"  wrote:
> 
> For several days I cannot connect to it. I can reach as far as to
> front page but clicking on linux-2.4 or linux-2.5 just timeouts.
> 
> TIA
> 
> -andrey
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm

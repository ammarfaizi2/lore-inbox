Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261451AbTAVPJb>; Wed, 22 Jan 2003 10:09:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261518AbTAVPJb>; Wed, 22 Jan 2003 10:09:31 -0500
Received: from bitmover.com ([192.132.92.2]:51921 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S261451AbTAVPJa>;
	Wed, 22 Jan 2003 10:09:30 -0500
Date: Wed, 22 Jan 2003 07:18:26 -0800
From: Larry McVoy <lm@bitmover.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Hua Zhong <huaz@sbcglobal.net>, David Schwartz <davids@webmaster.com>,
       dana.lacoste@peregrine.com, linux-kernel@vger.kernel.org
Subject: Re: Is the BitKeeper network protocol documented?
Message-ID: <20030122151826.GA23656@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Jamie Lokier <jamie@shareable.org>, Hua Zhong <huaz@sbcglobal.net>,
	David Schwartz <davids@webmaster.com>, dana.lacoste@peregrine.com,
	linux-kernel@vger.kernel.org
References: <CDEDIMAGFBEBKHDJPCLDCEEKCFAA.huaz@sbcglobal.net> <20030122071028.GA3466@bjl1.asuk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030122071028.GA3466@bjl1.asuk.net>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 07:10:28AM +0000, Jamie Lokier wrote:
> However if there was a project where the repository was _essential_ to
> do any meaningful work on the project, I suspect that a court of law
> would find that the repository is considered part of the source code
> per the GPL's definition.
> 
> (Note: I am not a lawyer nor have I paid for any advice.)

You're not understanding and respecting the concept of a boundary.
Suppose you had a GPLed driver and you put it in a BSD kernel, using the
driver boundary to limit the license pollution.  Suppose that your driver
only worked in that BSD kernel and it was useless without the kernel.
Your argument would say that the BSD kernel needs to be considered part
of the source per the GPL's definition.  Obviously incorrect.

A boundary is a boundary.  It doesn't matter how much you want or need
what is on the other side of that boundary, you don't get to make your
license cross that boundary, the law doesn't work that way.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

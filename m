Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286207AbSAEMms>; Sat, 5 Jan 2002 07:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288799AbSAEMmi>; Sat, 5 Jan 2002 07:42:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:53509 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S286207AbSAEMmY>; Sat, 5 Jan 2002 07:42:24 -0500
Date: Sat, 5 Jan 2002 12:42:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.2-pre8/drivers/mtd compilation fixes
Message-ID: <20020105124205.A30402@flint.arm.linux.org.uk>
In-Reply-To: <20020105025042.A23360@baldur.yggdrasil.com> <4082.1010229863@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4082.1010229863@redhat.com>; from dwmw2@infradead.org on Sat, Jan 05, 2002 at 11:24:23AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 05, 2002 at 11:24:23AM +0000, David Woodhouse wrote:
> Currently, it's only compiled in the iPAQ kernel tree, where it works - I'm
> waiting for the iPAQ people and Russell to stop arguing about how it should
> be done, so the result will work in the proper ARM tree (and hence Linus'
> tree) too.

I don't see this ever being solved.

Basically, the iPAQ people are quite happy to ignore concerns of the
non-iPAQ community to the point of ignoring any and all discussion
about it for months on end, so I'm happy to not merge the stuff until
they've addressed our concerns.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html


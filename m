Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289741AbSBNFT4>; Thu, 14 Feb 2002 00:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289761AbSBNFTq>; Thu, 14 Feb 2002 00:19:46 -0500
Received: from bitmover.com ([192.132.92.2]:11224 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S289749AbSBNFTn>;
	Thu, 14 Feb 2002 00:19:43 -0500
Date: Wed, 13 Feb 2002 21:19:43 -0800
From: Larry McVoy <lm@bitmover.com>
To: Michael Cohen <me@ohdarn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18-pre9-mjc2
Message-ID: <20020213211943.A25918@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Michael Cohen <me@ohdarn.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1013662709.6671.16.camel@ohdarn.net>; from me@ohdarn.net on Wed, Feb 13, 2002 at 11:58:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2002 at 11:58:28PM -0500, Michael Cohen wrote:
> [ I am now using bitkeeper, and my bk tree is available at
> bk://ohdarn.net/linux-mjc.  it is cloned from linus's 2.4 tree so
> please, please, please clone from him and pull from me. ]

Just in case people need a reminder, you would do this:

	bk clone bk://linux.bkbits.net/linux-2.4
	cd linux-2.4
	bk pull bk://ohdarn.net/linux-mjc

This means you use our bandwidth for the main clone and then only take
updates from Michael.

Michael, if you want to stash a mirror here, that's easy, take a look at

	http://www.bitkeeper.com/Hosted.html

it should be pretty straight forward.

Cheers,
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 

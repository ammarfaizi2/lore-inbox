Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281299AbRKEUCK>; Mon, 5 Nov 2001 15:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281305AbRKEUCA>; Mon, 5 Nov 2001 15:02:00 -0500
Received: from taltos.codesourcery.com ([66.92.14.85]:30339 "EHLO
	taltos.codesourcery.com") by vger.kernel.org with ESMTP
	id <S281299AbRKEUBt>; Mon, 5 Nov 2001 15:01:49 -0500
Date: Mon, 5 Nov 2001 12:01:43 -0800
From: Zack Weinberg <zack@codesourcery.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.2.20a and gcc 3.0 ?
Message-ID: <20011105120143.M267@codesourcery.com>
In-Reply-To: <20011104192024.H267@codesourcery.com> <3BE68F75.3010300@stesmi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE68F75.3010300@stesmi.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2001 at 02:09:09PM +0100, Stefan Smietanowski wrote:
> 
> I know how it's done, it's just that in my eyes a stable release is the 
> one where you know there's only 1 .... A 2.95.4 package built on 
> different days (from CVS) will differ. A 2.95.4 package built on 
> different ways from a .tar.gz marked as 'release' will not differ.
> 
> For instance chasing a kernel bug is difficult when 1 person might use 1 
> version of a compiler and another uses a different version when both 
> says 2.95.4, no matter how miniscule the difference.

Since patches are being applied to the 2.95 branch at a rate of about
one a month, I think the date stamp in the version number should be
quite sufficient to avoid any problems along these lines.

zw

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290528AbSAYDzN>; Thu, 24 Jan 2002 22:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290536AbSAYDzD>; Thu, 24 Jan 2002 22:55:03 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:59298 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id <S290528AbSAYDyz>;
	Thu, 24 Jan 2002 22:54:55 -0500
Date: Fri, 25 Jan 2002 14:53:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Pavel Machek <pavel@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Combined APM patch for 2.5.3-pre2
Message-Id: <20020125145345.16953a99.sfr@canb.auug.org.au>
In-Reply-To: <20020123173757.D78@toy.ucw.cz>
In-Reply-To: <20020121135046.574bfa60.sfr@canb.auug.org.au>
	<20020123173757.D78@toy.ucw.cz>
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On Wed, 23 Jan 2002 17:37:57 +0000
Pavel Machek <pavel@suse.cz> wrote:
> 
> > 	Rename kapm-idled to kapmd
> 
> Why? Leave the name alone. It does not matter, and it changed already
> too much in the past. It *is* idle thread!

Read the patch ... it is NOT the idle thread any longer .....
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
Linux APM Maintainer

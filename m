Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSKHJRh>; Fri, 8 Nov 2002 04:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261690AbSKHJRh>; Fri, 8 Nov 2002 04:17:37 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:11014 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S261693AbSKHJRg>; Fri, 8 Nov 2002 04:17:36 -0500
Date: Fri, 8 Nov 2002 10:24:16 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andy Grover <agrover@groveronline.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       acpi-devel@sourceforge.net
Subject: Re: [PATCH] Make ACPI unselectable in 2.4.20-rc1
Message-ID: <20021108092416.GA29848@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.44.0211071811450.3860-100000@dexter.groveronline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0211071811450.3860-100000@dexter.groveronline.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> My plan is to start feeding you bits of ACPI changes after 2.4.20 is 
> released. However, for 2.4.20, I'd like to make sure the really old code 
> in 2.4.20 doesn't bite any casual kernel builders.

There are no changes from 2.4.19, so I guess right thing is to leave
it there. People would loose their configs this way, etc.
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.

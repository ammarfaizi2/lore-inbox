Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267226AbTAAN3X>; Wed, 1 Jan 2003 08:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267227AbTAAN3X>; Wed, 1 Jan 2003 08:29:23 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:57022 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S267226AbTAAN3W>; Wed, 1 Jan 2003 08:29:22 -0500
Date: Wed, 1 Jan 2003 14:37:46 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: make gigabit ethernet into a real submenu
Message-ID: <20030101133746.GD14184@louise.pinerecords.com>
References: <20030101131925.GA14184@louise.pinerecords.com> <Pine.LNX.4.44.0301010824510.11858-100000@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301010824510.11858-100000@dell>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rpjday@mindspring.com]
>
> ... <snip> ...
> 
> perhaps a trivial question:  the first patch you sent out was against
> the Config.in file, which made perfect sense to me.  this patch
> is against the "Kconfig" file.  i'm not sure what that means,
> i see no such file.  (then again, being a kernel newbie, i probably
> just don't understand some of the fundamentals.)

The first patch (Config.in) went to Marcelo, the 2.4 maintainer.
The second patch (Kconfig) went to Linus, the 2.5 maintainer.

The kernel config system has been significantly reworked and improved
during 2.5 development.  Think of Kconfig as Config.in replacement.

-- 
Tomas Szepe <szepe@pinerecords.com>

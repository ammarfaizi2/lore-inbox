Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbSI1VHM>; Sat, 28 Sep 2002 17:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbSI1VHL>; Sat, 28 Sep 2002 17:07:11 -0400
Received: from ip68-13-110-204.om.om.cox.net ([68.13.110.204]:1408 "EHLO
	dad.molina") by vger.kernel.org with ESMTP id <S261679AbSI1VHL>;
	Sat, 28 Sep 2002 17:07:11 -0400
Date: Sat, 28 Sep 2002 16:12:31 -0500 (CDT)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@dad.molina
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix 2.5.39 floppy driver
In-Reply-To: <20020928202218.GB59189@compsoc.man.ac.uk>
Message-ID: <Pine.LNX.4.44.0209281611460.968-100000@dad.molina>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Sep 2002, John Levon wrote:

> On Sat, Sep 28, 2002 at 09:14:04PM +0200, Mikael Pettersson wrote:
> 
> >    Fixed by applying Al Viro's O100-get_gendisk-C38 patch.
> >    Fixed by applying Al Viro's O101-floppy_sizes-C38 patch.
> >    Quick fix: add the missing set_capacity() calls.
> 
> Works great for me. Thanks.

tested.  I'll mark this item fixed on my list when it makes it to bk.


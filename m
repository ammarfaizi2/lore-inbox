Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266112AbSKZOGy>; Tue, 26 Nov 2002 09:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266153AbSKZOGy>; Tue, 26 Nov 2002 09:06:54 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:2433 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id <S266112AbSKZOGy>; Tue, 26 Nov 2002 09:06:54 -0500
From: jlnance@unity.ncsu.edu
Date: Tue, 26 Nov 2002 09:14:09 -0500
To: Jeff Dike <jdike@karaya.com>, linux-kernel@vger.kernel.org
Subject: Re: uml-patch-2.5.49-1
Message-ID: <20021126141409.GA4589@ncsu.edu>
References: <200211260517.AAA05038@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211260517.AAA05038@ccure.karaya.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,
    Sounds like you are doing some good things with UML.  I particularly
like the fact that gdb will be easier to use.

On Tue, Nov 26, 2002 at 12:17:07AM -0500, Jeff Dike wrote:
> I welcome any comments on it.  The /proc/mm write semantics are less than
> ideal - I especially would like suggestions for improvements.

I think /proc/mm would be better implemented as /dev/mm.  It seems to
have a lot more functionality associated with it than most /proc files.

Thanks,

Jim

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbVI1PmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbVI1PmH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 11:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbVI1PmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 11:42:06 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:49590 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1751254AbVI1PmF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 11:42:05 -0400
Date: Wed, 28 Sep 2005 11:44:15 -0400
From: Bob Picco <bob.picco@hp.com>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Bob Picco <bob.picco@hp.com>
Subject: Re: [PATCH 0/7] HPET fixes and enhancements
Message-ID: <20050928154415.GD25483@localhost.localdomain>
References: <20050928071155.23025.43523.balrog@turing>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050928071155.23025.43523.balrog@turing>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Ladisch wrote:	[Wed Sep 28 2005, 03:11:55AM EDT]
> These patches remove a bunch of warts and quirks from the HPET drivers.
> 
> 
>  arch/i386/kernel/time_hpet.c |   20 +++++++++++---------
>  arch/x86_64/kernel/time.c    |   20 +++++++++++---------
>  drivers/char/hpet.c          |   39 ++++++++++++++++++++++++---------------
>  3 files changed, 46 insertions(+), 33 deletions(-)
> -
Ack on patches [1-4].

For x86_64 you can try Andi Kleen.  Venki and I weren't responsible
for x86_64 HPET.

thanks,

bob

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276305AbRJCOGd>; Wed, 3 Oct 2001 10:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276301AbRJCOGY>; Wed, 3 Oct 2001 10:06:24 -0400
Received: from cs.columbia.edu ([128.59.16.20]:30457 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S276305AbRJCOGP>;
	Wed, 3 Oct 2001 10:06:15 -0400
Date: Wed, 3 Oct 2001 10:06:43 -0400
Message-Id: <200110031406.f93E6hE06887@buggy.badula.org>
From: Ion Badulescu <ionut@cs.columbia.edu>
To: jdthood@home.dhs.org (Thomas Hood)
Cc: linux-kernel@vger.kernel.org
Subject: Re: PnP BIOS + 2.4.9-ac16 = no boot
In-Reply-To: <20011002232941.9921510E7@thanatos.toad.net>
User-Agent: tin/1.5.8-20010221 ("Blue Water") (UNIX) (Linux/2.4.8-ac9 (i586))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Oct 2001 19:29:41 -0400 (EDT), Thomas Hood <jdthood@home.dhs.org> wrote:
> I wrote:
>> Thanks for reporting this.  Please try 2.4.10-ac3.  If your
>> kernel won't boot, try booting with the "nobioscurrpnp" option.
> 
> Better yet, try 2.4.10-ac4  :)

Yup, -ac4 fixed the problem.

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

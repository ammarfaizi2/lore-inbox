Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283925AbRLAFBx>; Sat, 1 Dec 2001 00:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283926AbRLAFBn>; Sat, 1 Dec 2001 00:01:43 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:31998 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S283925AbRLAFBe>;
	Sat, 1 Dec 2001 00:01:34 -0500
Date: Sat, 1 Dec 2001 00:01:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.1-pre5 not easy to boot with devfs
In-Reply-To: <3C085FF3.813BAA57@wanadoo.fr>
Message-ID: <Pine.GSO.4.21.0112010001060.7958-100000@binet.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 1 Dec 2001, Pierre Rousselet wrote:

> As far as I can see,
> 
> when CONFIG_DEBUG_KERNEL is set
>   and 
> when devfsd is started at boot time
> I get an Oops when remounting, rw the root fs :
> 
> Unable to handle kernel request at va 5a5a5a5e
> ...
> EIP: 0010:[<c01516f9>] Not tainted

Umm...  How about a stack trace?


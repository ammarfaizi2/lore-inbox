Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132502AbRDUGP1>; Sat, 21 Apr 2001 02:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDUGPQ>; Sat, 21 Apr 2001 02:15:16 -0400
Received: from feral.com ([192.67.166.1]:31040 "EHLO feral.com")
	by vger.kernel.org with ESMTP id <S132502AbRDUGPJ>;
	Sat, 21 Apr 2001 02:15:09 -0400
Date: Fri, 20 Apr 2001 23:15:05 -0700 (PDT)
From: Matthew Jacob <mjacob@feral.com>
Reply-To: mjacob@feral.com
To: nbecker@fred.net
cc: linux-kernel@vger.kernel.org
Subject: Re: networked file system
In-Reply-To: <m33db3vv2m.fsf@nbecker.fred.net>
Message-ID: <Pine.BSF.4.21.0104202314320.64014-100000@beppo.feral.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Something like this was presented at OSDI, uh, year before last.. you might
check the Usenix webpage about this.


On 20 Apr 2001 nbecker@fred.net wrote:

> Suppose that an entry on any filesystem could be replaced by a symlink
> which pointed to a URL, and that an appropriate handler was dispatched
> for that URL.  This would allow, for example, config files to point to
> a different machine.
> 
> Right now we can accomplish this by mounting alternative file systems
> and symlinking to them, but only if an appropriate file system has
> been written.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292718AbSCJEzu>; Sat, 9 Mar 2002 23:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292866AbSCJEzl>; Sat, 9 Mar 2002 23:55:41 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:18899 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S292718AbSCJEzY>;
	Sat, 9 Mar 2002 23:55:24 -0500
Message-ID: <3C8AE73A.7040807@tmsusa.com>
Date: Sat, 09 Mar 2002 20:55:23 -0800
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020306
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.5.6 Interactive performance
In-Reply-To: <NFBBKFIFGLNJKLMMGGFPKEPDCFAA.charles-heselton@cox.net> <1015734229.858.4.camel@phantasy>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:

>The 2.5 tree also has most of these toys, and is a better place for this
>development IMO.  Personally, I'd stay away from these all-in-one silly
>patches that are floating around these days.  Your safest bet is just
>stock 2.4.18 or whatever is latest, although the above addons are all at
>varying levels of "stable" and "safe".
>

Just my $.02 -

After futzing around with all the various patches
floating around, I've found the -aa releases to be
a pleasant surprise all around. I generally run -aa
on my home and office workstations, as well as
the web/mail/dns/squid/firewall servers I manage.

I find I get 95% of the benefits of the bleeding
edge, with 5% of the effort - for instance:

untar 2.4.18
apply 2.4.19-pre2 patch
apply 2.4.19-pre2aa1 patch *
configure, compile, boot and enjoy.

* for nvidia drivers, back out xfs and 20_pte-highmem patches

Joe


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965057AbWIJAPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965057AbWIJAPu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 20:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965051AbWIJAPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 20:15:49 -0400
Received: from gw.goop.org ([64.81.55.164]:64412 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965048AbWIJAPr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 20:15:47 -0400
Message-ID: <45035286.8070209@goop.org>
Date: Sat, 09 Sep 2006 16:47:18 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Greg KH <gregkh@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Matthias Hentges <oe@hentges.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       linux-ide@vger.kernel.org, Jeff Garzik <jeff@garzik.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.18-rc5-mm1
References: <20060901015818.42767813.akpm@osdl.org> <1157158847.20509.10.camel@mhcln03> <20060901183028.1c6da4df.akpm@osdl.org> <44F93EB3.8050500@goop.org> <44F942B9.6050102@goop.org> <20060902084440.GA13361@suse.de>
In-Reply-To: <20060902084440.GA13361@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> There are 9 MSI patches in my tree that you can just remove.  They were
> just recently (a few hours ago) replaced with a total rewrite due to a
> number of different problems that were found.  So I'd suggest just
> waiting till the next -mm release to see if it works properly or not.
>   

I'm seeing exactly the same oops with CONFIG_MSI on 2.6.18-rc6-mm1.

    J

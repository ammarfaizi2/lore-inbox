Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932396AbWIVQXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932396AbWIVQXW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 12:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWIVQXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 12:23:22 -0400
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:14814 "EHLO
	smtp131.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S932396AbWIVQXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:23:21 -0400
Message-ID: <450E4C25.9030206@gentoo.org>
Date: Mon, 18 Sep 2006 03:35:01 -0400
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Tom St Denis <tomstdenis@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sky2 eth device with Gigabyte 965P-S3 motherboard
References: <bd0cb7950609200635qae3e0c6p3f7d776d33b50542@mail.gmail.com>	 <4513D362.8030804@gentoo.org> <bd0cb7950609220629i191683bq7b21fca3e04fafb1@mail.gmail.com>
In-Reply-To: <bd0cb7950609220629i191683bq7b21fca3e04fafb1@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom St Denis wrote:
> This won't be fixed as part of 2.6.18.x? 

Probably not.

> So why is it detected and
> working there but not in 2.6.18?

It wasn't detected under 2.6.17. Either your kernel is modified, or you 
were using the vendor sk98lin driver or something like that. If you have 
2.6.17 still bootable you could boot it and check the dmesg output to 
make sense of things.

Daniel

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264711AbSLCIiY>; Tue, 3 Dec 2002 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264815AbSLCIiY>; Tue, 3 Dec 2002 03:38:24 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:58411 "EHLO xsmtp.ethz.ch")
	by vger.kernel.org with ESMTP id <S264711AbSLCIiY>;
	Tue, 3 Dec 2002 03:38:24 -0500
Message-ID: <3DEC6F41.9000106@debian.org>
Date: Tue, 03 Dec 2002 09:45:53 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en, it-ch, it, fr
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Large block device patch, part 1 of 9
References: <fa.l4d1mqv.1ghm1h2@ifi.uio.no> <fa.j8nq6dv.14lihor@ifi.uio.no>
In-Reply-To: <fa.j8nq6dv.14lihor@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Dec 2002 08:45:54.0001 (UTC) FILETIME=[63D6F410:01C29AA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



H. Peter Anvin wrote:
> 
> While we're talking about printk()... is there any reason *not* to
> rename it printf()?

kprintf would be better, maybe addind the first argument for verbosity level,
instead of being "inlined" in the string. But it is a 2.7 change!

ciao
	giacomo


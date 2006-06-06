Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932069AbWFFCfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWFFCfn (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 22:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932071AbWFFCfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 22:35:43 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:29836
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932069AbWFFCfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 22:35:42 -0400
Message-ID: <4484E9DD.303@microgate.com>
Date: Mon, 05 Jun 2006 21:35:09 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: davej@redhat.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: 2.6.17-rc5-mm3
References: <20060603232004.68c4e1e3.akpm@osdl.org>	<20060605230248.GE3963@redhat.com>	<20060605184407.230bcf73.rdunlap@xenotime.net>	<4484E06B.9020609@microgate.com>	<20060605190355.c1be6d75.rdunlap@xenotime.net> <20060605191951.1ee122d3.rdunlap@xenotime.net>
In-Reply-To: <20060605191951.1ee122d3.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Mon, 5 Jun 2006 19:03:55 -0700 Randy.Dunlap wrote:
> Here's another version of the patch for you to consider.

This looks like the correct implementation of what I was trying (unsuccessfully)
to do when the random config errors were first reported.

I'll do testing tomorrow to make sure I understand this completely.

Thanks,
Paul

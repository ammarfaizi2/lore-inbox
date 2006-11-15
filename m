Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162084AbWKOXzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162084AbWKOXzE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 18:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162083AbWKOXzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 18:55:04 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:60687 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S1162087AbWKOXzB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 18:55:01 -0500
Message-ID: <455BA8C4.1040806@shadowen.org>
Date: Wed, 15 Nov 2006 23:54:44 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060927)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org
Subject: Re: Boot failure with ext2 and initrds
References: <20061114014125.dd315fff.akpm@osdl.org>	<20061114184919.GA16020@skynet.ie>	<Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>	<20061114113120.d4c22b02.akpm@osdl.org>	<455A5E93.6050709@shadowen.org> <20061114165806.753f0716.akpm@osdl.org>
In-Reply-To: <20061114165806.753f0716.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
OpenPGP: url=http://www.shadowen.org/~apw/public-key
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 15 Nov 2006 00:25:55 +0000
> Andy Whitcroft <apw@shadowen.org> wrote:
> 
>> Seeing this too.  Will try this patch out on the affected machines.
>>
>> If there are any others you recommend with it.  Yell.
>>
> 
> There are three, but kernel.org mirroring is taking *hours*, so I stuck
> them in http://userweb.kernel.org/~akpm/hot-fixes/

Yeah, what is it with mirroring over there.  Seems to have gone to hell
in a hand basket.

The automatic hotfix pickup seems to have done its thing and the results
should be out on TKO.  Generally looking _much_ better.

-apw

Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266622AbUBGD66 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266625AbUBGD66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:58:58 -0500
Received: from intra.cyclades.com ([64.186.161.6]:25786 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S266622AbUBGD6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:58:10 -0500
Date: Sat, 7 Feb 2004 01:55:08 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Santiago Garcia Mantinan <manty@manty.net>
Cc: linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] Fix PCMCIA card detection in 2.4 (in time for 2.4.25?)
In-Reply-To: <20040207010129.GA4513@man.manty.net>
Message-ID: <Pine.LNX.4.58L.0402070152530.23448@logos.cnet>
References: <20040207010129.GA4513@man.manty.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Feb 2004, Santiago Garcia Mantinan wrote:

> Hi!
>
> On 11th Aug 2003 I had reported yenya problems on Acer TravelMate 260 with
> 2.6.0test3, the bad news is that these problems also exist on 2.4 up to
> 2.4.25-test1, the good one is that Russell King had posted a fix on Oct 28
> 2003, similar subject than this message, that patch was for 2.6 and got into
> 2.6.0test10, so while this issue is solved in 2.6 kernels, it still exists
> in 2.4. Today I tried to aply Russell's patch to 2.4, I had to rewrite it,
> but otherwise it is exactly the same patch and it seems to work, at least in
> my machine.
>
> Can people test this so that we can clean up any doubts Marcelo may have and
> it gets roled into 2.4.25?

Hi Santiago,

A similar fix has been posted by Brad Campbell.

Applied his version (which had nicer identation), please test the BK tree.

Thanks.

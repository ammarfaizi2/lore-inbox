Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932502AbVISRMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932502AbVISRMr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 13:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVISRMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 13:12:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932502AbVISRMq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 13:12:46 -0400
Date: Mon, 19 Sep 2005 10:12:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Karsten Keil <kkeil@suse.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2/2] Remove URB_ASYNC_UNLINK from last patch
In-Reply-To: <20050919142409.GB2959@pingi3.kke.suse.de>
Message-ID: <Pine.LNX.4.58.0509191002530.9106@g5.osdl.org>
References: <20050919141037.GB13054@pingi3.kke.suse.de>
 <20050919142409.GB2959@pingi3.kke.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, Karsten Keil wrote:
> 
> Is here a way in git to "merge" these two patches ?

Just do "git diff a..b" to generate the diff over both of them (where "a" 
is the commit before the two, and "b" is the last one, of course).

Btw, the patch doesn't apply any more. I already applied your earlier one.

		Linus

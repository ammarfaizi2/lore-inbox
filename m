Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267502AbUHWIQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267502AbUHWIQd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 04:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267536AbUHWIQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 04:16:33 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:61130 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267502AbUHWIQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 04:16:32 -0400
Date: Mon, 23 Aug 2004 04:20:49 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: "David S. Miller" <davem@redhat.com>
Cc: Keith Owens <kaos@ocs.com.au>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       wli@holomorphy.com
Subject: Re: [PATCH][1/4] Completely out of line spinlocks / i386
In-Reply-To: <20040822214040.4c866da2.davem@redhat.com>
Message-ID: <Pine.LNX.4.58.0408230420270.27390@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0408221740090.27390@montezuma.fsmlabs.com>
 <22241.1093220988@ocs3.ocs.com.au> <20040822214040.4c866da2.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, David S. Miller wrote:

> On Mon, 23 Aug 2004 10:29:48 +1000
> Keith Owens <kaos@ocs.com.au> wrote:
>
> > I find that the decoding the lock is useful but not required,
> > the function that contended on the lock is more interesting.
>
> This is my belief as well.

That's great then, we have that covered =)


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266149AbUHYX3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266149AbUHYX3a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:29:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUHYX3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:29:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:61630 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266149AbUHYX3L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:29:11 -0400
Date: Wed, 25 Aug 2004 16:32:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Spam <spam@tnonline.net>
Cc: torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-Id: <20040825163225.4441cfdd.akpm@osdl.org>
In-Reply-To: <1453698131.20040826011935@tnonline.net>
References: <20040824202521.GA26705@lst.de>
	<412CEE38.1080707@namesys.com>
	<20040825152805.45a1ce64.akpm@osdl.org>
	<112698263.20040826005146@tnonline.net>
	<Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org>
	<1453698131.20040826011935@tnonline.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Spam <spam@tnonline.net> wrote:
>
> > In other words, if reiserfs does something special, we should make 
> > standard interfaces for doing that special thing, so that everybody can
> > do it without stepping on other peoples toes.
> 
>   Agreed  that would be the best. But how much time and effort will it
>   be

Zero.

We can add these new features tomorrow, as reiser4-only features, with a
plan in hand to generalise them later.

-->>__if__<<-- we think these are features which Linux should offer.


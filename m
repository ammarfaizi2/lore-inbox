Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWIVTXT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWIVTXT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 15:23:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWIVTXT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 15:23:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964779AbWIVTXS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 15:23:18 -0400
Date: Fri, 22 Sep 2006 12:22:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Ulrich Drepper <drepper@redhat.com>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
Subject: Re: [take19 0/4] kevent: Generic event handling mechanism.
Message-Id: <20060922122207.3b716028.akpm@osdl.org>
In-Reply-To: <11587449471424@2ka.mipt.ru>
References: <115a6230591036@2ka.mipt.ru>
	<11587449471424@2ka.mipt.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 13:35:47 +0400
Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:

> Generic event handling mechanism.
> 
> Consider for inclusion.

Ulrich's objections sounded substantial, and afaik remain largely
unresolved.   How do we sort this out?

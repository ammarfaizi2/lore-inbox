Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbUL3PMo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbUL3PMo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 10:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261651AbUL3PMo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 10:12:44 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:63128 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S261638AbUL3PMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 10:12:43 -0500
Message-ID: <41D429A2.4CDCCE7C@tv-sign.ru>
Date: Thu, 30 Dec 2004 19:15:30 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2 2.6.10] rcu: simplify quiescent state detection
References: <Pine.LNX.4.44.0412291623320.7011-100000@dbl.q-ag.de>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> No, it's not needed. Actually: not even a counter is needed, just
> a flag that indicates that there was a quiescent state.
> 

Yes, this patch is obviously better.

Oleg.

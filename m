Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262811AbTETAFT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTETADj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:03:39 -0400
Received: from dp.samba.org ([66.70.73.150]:5264 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262445AbTETAD1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:03:27 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [patch] futex requeueing feature, futex-requeue-2.5.69-D3 
In-reply-to: Your message of "Mon, 19 May 2003 11:10:28 +0100."
             <20030519111028.B8663@infradead.org> 
Date: Tue, 20 May 2003 10:08:46 +1000
Message-Id: <20030520001623.8BE182C0F9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030519111028.B8663@infradead.org> you write:
> Urgg, yet another sys_futex extension.  Could you please split all
> these totally different cases into separate syscalls instead?

I don't mind either way, but wouldn't that be pointless incompatible
churn?

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

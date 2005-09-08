Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965074AbVIHXfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965074AbVIHXfE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 19:35:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVIHXfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 19:35:03 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965074AbVIHXfC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 19:35:02 -0400
Date: Thu, 8 Sep 2005 16:34:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: s864@ii.uib.no (Ronny V. Vindenes)
Cc: roland@redhat.com, linux-kernel@vger.kernel.org,
       Parag Warudkar <kernel-stuff@comcast.net>, Andi Kleen <ak@muc.de>
Subject: Re: 2.6.13-mm2
Message-Id: <20050908163410.5f1bfc80.akpm@osdl.org>
In-Reply-To: <m3slwfxhxd.fsf@localhost.localdomain>
References: <4KtRD-7Nt-13@gated-at.bofh.it>
	<m3slwfxhxd.fsf@localhost.localdomain>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

s864@ii.uib.no (Ronny V. Vindenes) wrote:
>
> x86-64-ptrace-ia32-bp-fix.patch breaks all 32bit apps for me on Athlon64

Great, thanks muchly for working that out.

Parag, perhaps you could confirm that reverting that patch fixes things up?

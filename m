Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266122AbTIKGQp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 02:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266132AbTIKGQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 02:16:45 -0400
Received: from dp.samba.org ([66.70.73.150]:28860 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S266122AbTIKGQp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 02:16:45 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, alan@redhat.com
Subject: Re: [Kernel-janitors] [PATCH] Remove modules.txt 
In-reply-to: Your message of "Wed, 10 Sep 2003 13:14:41 +0200."
             <200309101314.41460.arnd@arndb.de> 
Date: Thu, 11 Sep 2003 15:32:38 +1000
Message-Id: <20030911061644.B8A592C0C7@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200309101314.41460.arnd@arndb.de> you write:
> The whole file has only historic value and should probably be removed
> or have a comment that it does not apply to the current code.

Agreed.  Linus, please delete Documentation/smp.tex.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

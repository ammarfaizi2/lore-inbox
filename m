Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbUAHAZL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262580AbUAHAXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:23:49 -0500
Received: from dp.samba.org ([66.70.73.150]:8321 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262540AbUAHAXA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 19:23:00 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL PATCH] correct kgdb.txt Documentation link (against 2.6.1-rc1-mm2) 
In-reply-to: Your message of "Tue, 06 Jan 2004 02:03:53 BST."
             <Pine.LNX.4.56.0401060156570.7407@jju_lnx.backbone.dif.dk> 
Date: Thu, 08 Jan 2004 11:14:21 +1100
Message-Id: <20040108002257.7BA572C4F9@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.56.0401060156570.7407@jju_lnx.backbone.dif.dk> you write
:
> 
> The help text for "config KGDB" in arch/i386/Kconfig refers to
> Documentation/i386/kgdb.txt - the actual location is
> Documentation/i386/kgdb/kgdb.txt - patch below to fix that.

-mm only patch.  Please send to Andrew Morton.

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261725AbUKUB46@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261725AbUKUB46 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 20:56:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbUKUBz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 20:55:26 -0500
Received: from dp.samba.org ([66.70.73.150]:5297 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261725AbUKUByP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 20:54:15 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16799.60420.474050.298073@samba.org>
Date: Sun, 21 Nov 2004 12:14:44 +1100
To: Andrew Morton <akpm@osdl.org>
Cc: reiser@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: performance of filesystem xattrs with Samba4
In-Reply-To: <20041119162651.2d62a6a8.akpm@osdl.org>
References: <16797.41728.984065.479474@samba.org>
	<419E1297.4080400@namesys.com>
	<16798.31565.306237.930372@samba.org>
	<20041119162651.2d62a6a8.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: tridge@samba.org
From: tridge@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

 > Is it reproducible with your tricked-up dbench?

The xattr enabled dbench I did for Stephen was just a quick hack to
demonstrate the oops in ext3. I'll do a more complete version over the
next few days.

Cheers, Tridge

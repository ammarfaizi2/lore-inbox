Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbULEUXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbULEUXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 15:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261380AbULEUXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 15:23:36 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:64199 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S261379AbULEUXg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 15:23:36 -0500
Subject: Re: [PATCH] Document kfree and vfree NULL usage (resend)
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: Kernel Stuff <kernel-stuff@comcast.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <41B33E70.2000107@colorfullife.com>
References: <Pine.LNX.4.44.0412051628280.13644-100000@dbl.q-ag.de>
	 <200412051105.10934.kernel-stuff@comcast.net>
	 <41B33E70.2000107@colorfullife.com>
Date: Sun, 05 Dec 2004 22:21:41 +0200
Message-Id: <1102278101.19406.0.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-12-05 at 17:59 +0100, Manfred Spraul wrote:
> And you are right: for vfree, it's "must not be called". I'll send a 
> separate patch. Or Andrew could just change it directly.

Please do it for vunmap() also.

			Pekka


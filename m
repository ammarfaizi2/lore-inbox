Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751167AbWIWIog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751167AbWIWIog (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 04:44:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWIWIog
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 04:44:36 -0400
Received: from smtp.osdl.org ([65.172.181.4]:34973 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751167AbWIWIof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 04:44:35 -0400
Date: Sat, 23 Sep 2006 01:44:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: 2.6.18 - vesafb unaiavilable if fbcon compiled as module
Message-Id: <20060923014423.e57b2fae.akpm@osdl.org>
In-Reply-To: <200609231140.50220.arvidjaar@mail.ru>
References: <200609231140.50220.arvidjaar@mail.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Sep 2006 11:40:49 +0400
Andrey Borzenkov <arvidjaar@mail.ru> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Is it intentional? In Kconfig:
> 
> config FB_VESA
>         bool "VESA VGA graphics support"
>         depends on (FB = y) && X86
> 

cc's added.

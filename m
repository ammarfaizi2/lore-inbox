Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVCVCoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVCVCoK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 21:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVCVCmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 21:42:36 -0500
Received: from fire.osdl.org ([65.172.181.4]:27548 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262265AbVCVB5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 20:57:45 -0500
Date: Mon, 21 Mar 2005 17:57:07 -0800
From: Andrew Morton <akpm@osdl.org>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, dave.m@email.it, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.11.4 vaio z1xmp mouse click
Message-Id: <20050321175707.2e0befb1.akpm@osdl.org>
In-Reply-To: <d120d500050318073671f15ad6@mail.gmail.com>
References: <200503141916.30252.dave.m@email.it>
	<d120d500050318073671f15ad6@mail.gmail.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> On Mon, 14 Mar 2005 19:16:29 +0100, dave <dave.m@email.it> wrote:
> > 
> > hy,
> > 
> > Upgrading kernel from Linux 2.6.10 (full) to 2.6.11.4(full) the left mouse
> > click get losed (I can not clik).
> 
> Is your touchpad being detected as an ALPS touchpad? There are some
> issues with tapping that should be fixed in 2.6.12. In the meantime
> you could try 2.6.11-mm or force PS/2 compatinbility mode by bootintg
> with psmouse.proto=exps on kernel command line.

Did we hear back from Dave on this?

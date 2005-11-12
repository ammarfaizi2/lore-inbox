Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVKLCGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVKLCGs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 21:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751209AbVKLCGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 21:06:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:34539 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750758AbVKLCGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 21:06:48 -0500
Date: Fri, 11 Nov 2005 18:06:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kumar Gala <galak@gate.crashing.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Update email address for Kumar
Message-Id: <20051111180633.6fbdae89.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0511101128310.18480-100000@gate.crashing.org>
References: <Pine.LNX.4.44.0511101128310.18480-100000@gate.crashing.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@gate.crashing.org> wrote:
>
> Changed jobs and the Freescale address is no longer valid.
> 
> ...
>
> - * Maintainer: Kumar Gala <kumar.gala@freescale.com>
> + * Maintainer: Kumar Gala <galak@kernel.crashing.org>

Bless you for putting this into each file - I hate going into a great
forensic flurry trying to work out who broke^Wmaintains a particular piece
of code, particularly as I have to do this at ~5Hz.

That being said, it would be better to use just "Kumar Gala" and to put the
actual email address into the MAINTAINERS file.

For future reference.  I assume you'll still be @crashing.org if you change
employers again anyway.


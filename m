Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVFCX2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVFCX2N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 19:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVFCX2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 19:28:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:34529 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261171AbVFCX2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 19:28:11 -0400
Date: Fri, 3 Jun 2005 16:28:56 -0700
From: Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc5 : repeatable modprobe usb-storage hang
Message-Id: <20050603162856.1a80af82.akpm@osdl.org>
In-Reply-To: <200506031341.17749.kernel-stuff@comcast.net>
References: <200506031341.17749.kernel-stuff@comcast.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
>
> On 2.6.12-rc5 modprobe usb-storage hangs forever - it is reproducible most of 
> the times.

Did it work OK under earlier kernels?  If so, which?

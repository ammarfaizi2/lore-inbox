Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751283AbVJSUBl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbVJSUBl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 16:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbVJSUBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 16:01:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65189 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751283AbVJSUBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 16:01:40 -0400
Date: Wed, 19 Oct 2005 13:01:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Brian D. McGrew" <brian@visionpro.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: idle=poll
Message-Id: <20051019130103.32c85b16.akpm@osdl.org>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0970355@chicken.machinevisionproducts.com>
References: <14CFC56C96D8554AA0B8969DB825FEA0970355@chicken.machinevisionproducts.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian D. McGrew" <brian@visionpro.com> wrote:
>
> Is there any kind of an ioctl in the kernel for turning on/off idle=poll
>  on the fly without having to reboot?

Nope.

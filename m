Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWJLVy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWJLVy2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbWJLVy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:54:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54725 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751095AbWJLVy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:54:28 -0400
Date: Thu, 12 Oct 2006 14:54:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Miguel Ojeda Sandonis <maxextreme@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.19-rc1 update 2] drivers: add LCD support
Message-Id: <20061012145422.65958578.akpm@osdl.org>
In-Reply-To: <20061012140422.93e7330c.maxextreme@gmail.com>
References: <20061012140422.93e7330c.maxextreme@gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 14:04:22 +0000
Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:

> Andrew, here it is the patch for converting the cfag12864b driver
> to a framebuffer driver as Pavel requested and as I promised :)

I'm all confused.  This patch patches drivers/auxdisplay/fbcfag12864b.c,
but there's no file of that name in any patches I have.

I'll drop everything - please send a shiny new patch against current Linus
mainline, thanks.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUJUNmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUJUNmz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267362AbUJUNju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:39:50 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:14728 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S263795AbUJTOvG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 10:51:06 -0400
Subject: Re: Module compilation
From: David Woodhouse <dwmw2@infradead.org>
To: root@chaos.analogic.com
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
References: <Pine.LNX.4.61.0410201034590.12062@chaos.analogic.com>
Content-Type: text/plain
Message-Id: <1098283790.3872.115.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 20 Oct 2004 15:49:50 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-10-20 at 10:36 -0400, Richard B. Johnson wrote:
> Could whomever remade the kernel Makefile, please add
> a variable, initially set to "", like CFLAGS_KERNEL, that
> is exported and is always included on the compiler command-
> line?

EXTRA_CFLAGS

-- 
dwmw2



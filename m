Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932661AbWGADj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932661AbWGADj3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 23:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932557AbWGADi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 23:38:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:38119 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932479AbWGADiu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 23:38:50 -0400
Date: Fri, 30 Jun 2006 20:35:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fs/read_write.c: EXPORT_UNUSED_SYMBOL
Message-Id: <20060630203537.34137dc0.akpm@osdl.org>
In-Reply-To: <20060630113256.GS19712@stusta.de>
References: <20060630113256.GS19712@stusta.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Jun 2006 13:32:56 +0200
Adrian Bunk <bunk@stusta.de> wrote:

> -EXPORT_SYMBOL(iov_shorten);
> +EXPORT_UNUSED_SYMBOL(iov_shorten);  /*  June 2006  */

OK.

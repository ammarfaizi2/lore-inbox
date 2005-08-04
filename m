Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVHDExU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVHDExU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261805AbVHDEvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:51:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56509 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261793AbVHDEuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:50:06 -0400
Date: Wed, 3 Aug 2005 21:48:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: domen@coderock.org
Cc: linux-kernel@vger.kernel.org, Jan.Veldeman@advalvas.be, domen@coderock.org
Subject: Re: [patch 4/5] Driver core: Documentation: fix whitespace between
 parameters
Message-Id: <20050803214855.21daa22c.akpm@osdl.org>
In-Reply-To: <20050731111216.428775000@homer>
References: <20050731111216.428775000@homer>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

domen@coderock.org wrote:
>
> Fix whitespace after comma between parameters.
> ...
> -#define DEVICE_ATTR(_name,_mode,_show,_store)      \
> +#define DEVICE_ATTR(_name, _mode, _show, _store)      \
>

I think this one's a bit _too_ trivial, really.  Yes, it's irritating, but
the tree is absolutely full of such things.



Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbTIBLlZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTIBLlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:41:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59291 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261305AbTIBLlV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:41:21 -0400
Date: Tue, 2 Sep 2003 04:31:50 -0700
From: "David S. Miller" <davem@redhat.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] MODULE_ALIAS() in network families
Message-Id: <20030902043150.4e7ce11a.davem@redhat.com>
In-Reply-To: <20030902081828.E8E8A2C0D2@lists.samba.org>
References: <20030902081828.E8E8A2C0D2@lists.samba.org>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Sep 2003 18:18:05 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Name: MODULE_ALIAS inside modules: network protocols
> Author: Rusty Russell
> Status: Booted on 2.6.0-test4-bk3
> 
> D: Previously, default aliases were hardwired into modutils.  Now they
> D: should be inside the modules, using MODULE_ALIAS() (they will be overridden
> D: by any user alias).

Looks great, applied.

Thanks Rusty.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, 02 Sep 2003 18:18:05 +1000
Rusty Russell <rusty@rustcorp.com.au> wrote:

> Name: MODULE_ALIAS inside modules: network protocols
> Author: Rusty Russell
> Status: Booted on 2.6.0-test4-bk3
> 
> D: Previously, default aliases were hardwired into modutils.  Now they
> D: should be inside the modules, using MODULE_ALIAS() (they will be overridden
> D: by any user alias).

Looks great, applied.

Thanks Rusty.

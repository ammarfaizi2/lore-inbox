Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWFXWbH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWFXWbH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751134AbWFXWbH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:31:07 -0400
Received: from xenotime.net ([66.160.160.81]:64902 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751136AbWFXWbG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:31:06 -0400
Date: Sat, 24 Jun 2006 15:33:53 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: mgross@linux.intel.com
Cc: arjan@infradead.org, linux-kernel@vger.kernel.org, mark.gross@intel.com
Subject: Re: [PATCH] riport LADAR driver
Message-Id: <20060624153353.fcc3633b.rdunlap@xenotime.net>
In-Reply-To: <20060623224654.GA5204@linux.intel.com>
References: <20060622144120.GA5215@linux.intel.com>
	<1151000401.3120.55.camel@laptopd505.fenrus.org>
	<20060622231604.GA5208@linux.intel.com>
	<20060622225239.bf0ccab2.rdunlap@xenotime.net>
	<20060623224654.GA5204@linux.intel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jun 2006 15:46:54 -0700 mark gross wrote:

> +module_param(io, int, 0444);
> +MODULE_PARM_DESC(io, "if non-zero then overrides IO port address");
> +
> +module_param(irq, int, 0444);
> +MODULE_PARM_DESC(io, "if non-zero then overrides IRQ number");
                    irq

> +module_param(size, int, 0444);
> +MODULE_PARM_DESC(io, "if non-zero then overrides buffer size");
                    size

Did you ever update these?  I mentioned them in a previous
email.

---
~Randy

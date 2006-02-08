Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030576AbWBHHdp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030576AbWBHHdp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 02:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030575AbWBHHdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 02:33:45 -0500
Received: from smtp.osdl.org ([65.172.181.4]:13495 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030576AbWBHHdp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 02:33:45 -0500
Date: Tue, 7 Feb 2006 23:33:18 -0800
From: Andrew Morton <akpm@osdl.org>
To: Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
Message-Id: <20060207233318.33fbdd8a.akpm@osdl.org>
In-Reply-To: <20060208062007.GA7936@kroah.com>
References: <20060208062007.GA7936@kroah.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> wrote:
>
>  +				printk(KERN_WARNING "symbol %s is being used "
>  +					"by a non-GPL module, which will not "
>  +					"be allowed in the future\n", name);

"See Documentation/feature-removal.txt for details".

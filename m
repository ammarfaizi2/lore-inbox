Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVBGTTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVBGTTb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 14:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVBGTQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 14:16:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:20375 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261248AbVBGTNc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 14:13:32 -0500
Date: Mon, 7 Feb 2005 11:13:21 -0800
From: Andrew Morton <akpm@osdl.org>
To: John Rose <johnrose@austin.ibm.com>
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, greg@kroah.com.torvalds
Subject: Re: [PATCH] PCI Hotplug: remove incorrect rpaphp firmware
 dependency
Message-Id: <20050207111321.1282f763.akpm@osdl.org>
In-Reply-To: <1107798322.31219.8.camel@sinatra.austin.ibm.com>
References: <200502031908.j13J8ggb031915@hera.kernel.org>
	<1107795637.19262.426.camel@hades.cambridge.redhat.com>
	<1107798068.31219.6.camel@sinatra.austin.ibm.com>
	<1107798322.31219.8.camel@sinatra.austin.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Rose <johnrose@austin.ibm.com> wrote:
>
> Could we please get David's fix in for 2.6.11, since it's apparently
>  affecting boot in some situations?

Yup, I can take care of that.

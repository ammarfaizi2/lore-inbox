Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbUC0BTe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 20:19:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbUC0BTe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 20:19:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:13014 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261558AbUC0BTd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 20:19:33 -0500
Date: Fri, 26 Mar 2004 17:21:42 -0800
From: Andrew Morton <akpm@osdl.org>
To: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <ramon.rey@hispalinux.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.6.5-rc2-mm4
Message-Id: <20040326172142.5d39a23f.akpm@osdl.org>
In-Reply-To: <1080349825.9689.9.camel@debian>
References: <20040326131816.33952d92.akpm@osdl.org>
	<1080349825.9689.9.camel@debian>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ramón Rey Vicente <ramon.rey@hispalinux.es> wrote:
>
> -static inline int register_profile_notifier*struct notifier_block * nb)
> +static inline int register_profile_notifier(struct notifier_block * nb)

You have a single-bit error.  Treat yourself to a new computer ;)

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbVLMXZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVLMXZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:25:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbVLMXZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:25:20 -0500
Received: from smtp.osdl.org ([65.172.181.4]:714 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030245AbVLMXZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:25:19 -0500
Date: Tue, 13 Dec 2005 15:24:50 -0800
From: Andrew Morton <akpm@osdl.org>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc5-mm1
Message-Id: <20051213152450.733aff26.akpm@osdl.org>
In-Reply-To: <20051213234918.456131df@werewolf.auna.net>
References: <20051204232153.258cd554.akpm@osdl.org>
	<20051213234918.456131df@werewolf.auna.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J.A. Magallon" <jamagallon@able.es> wrote:
>
> On Sun, 4 Dec 2005 23:21:53 -0800, Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15-rc5/2.6.15-rc5-mm1/
> > 
> 
> mmm, this patch GPL'ed all pci_xxxxxx functions, so it broke what you
> all know.

That'll be gregkh-pci-shot-accross-the-bow.patch.

> Final attack against binary drivers ? Or just an API change ?

A joke, I believe.

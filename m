Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269260AbUJFNKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269260AbUJFNKk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269262AbUJFNKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:10:39 -0400
Received: from iua-mail.upf.es ([193.145.55.10]:41374 "EHLO iua-mail.upf.es")
	by vger.kernel.org with ESMTP id S269260AbUJFNKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:10:25 -0400
Date: Wed, 6 Oct 2004 15:10:14 +0200
From: Maarten de Boer <mdeboer@iua.upf.es>
To: Paul Fulghum <paulkf@microgate.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Badness in enable_irq with 2.6.9-rc3-mm2-vp-t1
Message-Id: <20041006151014.5c7de38e.mdeboer@iua.upf.es>
In-Reply-To: <1097067996.1990.2.camel@deimos.microgate.com>
References: <20041006145546.1a611d27.mdeboer@iua.upf.es>
	<1097067996.1990.2.camel@deimos.microgate.com>
Organization: IUA-MTG
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.4.9; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MTG-MailScanner: Found to be clean
X-MTG-MailScanner-SpamCheck: not spam (whitelisted),
	SpamAssassin (score=-2.599, required 5, autolearn=disabled,
	BAYES_00 -2.60)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is a known problem.
> The maintainers are working on a solution.

Ok.

> It is only a warning and the e100 will
> continue to work.

Hm, for me it didn't. To be more precise, configuring networking with
DHCP failed. But maybe that problem is somewhere else.

maarten

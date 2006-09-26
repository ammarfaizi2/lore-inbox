Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbWIZA3u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbWIZA3u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 20:29:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbWIZA3u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 20:29:50 -0400
Received: from khc.piap.pl ([195.187.100.11]:15016 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751658AbWIZA3t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 20:29:49 -0400
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NV SATA breakage: jgarzik/libata-dev#upstream etc
References: <m3wt7tm6sh.fsf@defiant.localdomain> <451721F8.4060600@pobox.com>
	<m3vencjeit.fsf@defiant.localdomain>
	<m364fbrhow.fsf@defiant.localdomain> <45185625.4050906@pobox.com>
	<m3fyef1p6f.fsf@defiant.localdomain> <45186BAC.70404@pobox.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Tue, 26 Sep 2006 02:29:45 +0200
In-Reply-To: <45186BAC.70404@pobox.com> (Jeff Garzik's message of "Mon, 25 Sep 2006 19:52:12 -0400")
Message-ID: <m3bqp31nd2.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> writes:

> The argument to ata_pci_init_native_mode() was also updated.
>
> Just for sanity's sake, could you test linux-2.5.git + my patch?

I've already tested nearly identical patch against your latest tree
(currently equal to Linus' - a6d967a485c67ec8a1276261f39d81ace6a3e308)
and it works fine, so Acked-By: Krzysztof Halasa <khc@pm.waw.pl>
-- 
Krzysztof Halasa

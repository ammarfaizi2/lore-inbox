Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTHVO7j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 10:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbTHVO7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 10:59:38 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:18340 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263229AbTHVO7f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 10:59:35 -0400
Date: Fri, 22 Aug 2003 11:09:20 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] noapic should depend on ioapic config not local
Message-ID: <20030822110920.B639@nightmaster.csn.tu-chemnitz.de>
References: <20030821052140.GA19039@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20030821052140.GA19039@gtf.org>; from jgarzik@pobox.com on Thu, Aug 21, 2003 at 01:21:40AM -0400
X-Spam-Score: -4.7 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19qDO2-00004q-00*V3KnZF0TowU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 01:21:40AM -0400, Jeff Garzik wrote:
> Zwane's comment was correct, it needs to be CONFIG_X86_IO_APIC.

Does this also apply to 2.4.22-rc2?

I must use noapic on my system and 2.4.22 does ignore it, while
2.4.21 doesn't.

Regards

Ingo Oeser

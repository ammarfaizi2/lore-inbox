Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263288AbTIVU4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263291AbTIVU4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:56:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:59544 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263288AbTIVU4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:56:42 -0400
Date: Mon, 22 Sep 2003 13:56:32 -0700
From: Chris Wright <chrisw@osdl.org>
To: Ruediger Scholz <rscholz@hrzpub.tu-darmstadt.de>
Cc: Chris Wright <chrisw@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: irq 9: nobody cared!
Message-ID: <20030922135632.C18606@osdlab.pdx.osdl.net>
References: <3F6EBEC7.7050204@hrzpub.tu-darmstadt.de> <20030922103028.A18616@osdlab.pdx.osdl.net> <3F6F5769.2040504@hrzpub.tu-darmstadt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3F6F5769.2040504@hrzpub.tu-darmstadt.de>; from rscholz@hrzpub.tu-darmstadt.de on Mon, Sep 22, 2003 at 10:11:21PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Ruediger Scholz (rscholz@hrzpub.tu-darmstadt.de) wrote:
> Chris Wright schrieb:
> 
> > <snip>
> >
> >Can you try this patch against 2.6.0-test5-mm3?  PCI IRQ routing is
> >broken in some circumstances with ACPI.
> >
> Thank you very, very much. Now really everything is working fine without 
> any special ACPI bootparam. I've just listen to some music but no error 
> message like the former ones appeared... :-)

Great, thanks for the feedback.

> Will this patch go into mainstrem kernel?

Yes, we're working at getting it integrated.
thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net

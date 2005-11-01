Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbVKAMxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbVKAMxn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 07:53:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKAMxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 07:53:43 -0500
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:10624 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S1750772AbVKAMxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 07:53:42 -0500
Subject: Re: patch to add a config option to enable SATA ATAPI by default
From: Mark Tomich <tomichm@bellsouth.net>
To: Olaf Hering <olh@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20051101073555.GA11890@suse.de>
References: <1130691328.8303.8.camel@localhost>
	 <20051031102723.GA10037@suse.de> <4365FF53.8000707@pobox.com>
	 <1130810963.21921.4.camel@localhost>  <20051101073555.GA11890@suse.de>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 07:53:40 -0500
Message-Id: <1130849620.8067.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sounds good.  Thanks again!

On Tue, 2005-11-01 at 08:35 +0100, Olaf Hering wrote:
>  On Mon, Oct 31, Mark Tomich wrote:
> 
> > Maybe I'm just not doing it properly, but I wasn't able to specify the
> > "atapi_enabled" option on the kernel command line.  I tried it, but it
> > still didn't see my  CD-ROM drive.  That's why I wrote the patch.
> 
> Use modulename.moduleoption=value, libata.atapi_enabled=1 will likely work.
> 


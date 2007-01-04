Return-Path: <linux-kernel-owner+w=401wt.eu-S932369AbXADKlQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbXADKlQ (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 05:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXADKlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 05:41:16 -0500
Received: from sd291.sivit.org ([194.146.225.122]:3265 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932352AbXADKlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 05:41:15 -0500
X-Greylist: delayed 1887 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 05:41:15 EST
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
From: Stelian Pop <stelian@popies.net>
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org
In-Reply-To: <200701040024.29793.lenb@kernel.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Thu, 04 Jan 2007 11:09:44 +0100
Message-Id: <1167905384.7763.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 04 janvier 2007 à 00:24 -0500, Len Brown a écrit :

> > > I'd like to keep this driver out-of-tree
> > > until we prove that we can't enhance the
> > > generic code to handle this hardware
> > > without the addition of a new driver.
> > 
> > How long is this going to take ?
> 
> How about 2.6.21?

Good news !

> What needs to happen is
> 1. a maintainer for sony_acpi.c needs to step forward
>     I can't do this, I'm not allowed to be in the reverse engineering business.

Well, I can't do this either, because I just don't have the required
hardware anymore.

If someone want to step forward now it is a great time !
> 
> 2. /proc/acpi/sony API needs to be deleted
> 
> 3. source needs to move out of drivers/acpi, and into drivers/misc along with msi.

Sensible suggestions, the new maintainer will have to work on this.

Thanks Len.

-- 
Stelian Pop <stelian@popies.net>


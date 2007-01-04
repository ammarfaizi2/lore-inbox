Return-Path: <linux-kernel-owner+w=401wt.eu-S965085AbXADVhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbXADVhN (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 16:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbXADVhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 16:37:13 -0500
Received: from cantor2.suse.de ([195.135.220.15]:47773 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965085AbXADVhL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 16:37:11 -0500
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
From: Timo Hoenig <thoenig@nouse.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Mattia Dongili <malattia@linux.it>, Stelian Pop <stelian@popies.net>,
       Len Brown <lenb@kernel.org>, Ismail Donmez <ismail@pardus.org.tr>,
       Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
In-Reply-To: <20070104132834.99a585c9.akpm@osdl.org>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
	 <200701040024.29793.lenb@kernel.org>
	 <1167905384.7763.36.camel@localhost.localdomain>
	 <20070104191512.GC25619@inferi.kami.home>
	 <20070104125107.b82db604.akpm@osdl.org>
	 <20070104211830.GD25619@inferi.kami.home>
	 <20070104132834.99a585c9.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 22:36:24 +0100
Message-Id: <1167946584.31915.9.camel@nouse.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2007-01-04 at 13:28 -0800, Andrew Morton wrote:

> spose so.  I don't know if any apps are dependent upon the /proc file,
> but the driver isn't in mainline yet so it's unlikely that there's a
> mountain of software depending upon existing interfaces.

Not a mountain, but still a few applications support that interface.

At least the powersave daemon 'powersaved' and HAL support the
brightness interface of the Sony driver.

The responsible developers are following the linux-acpi list.

   Timo


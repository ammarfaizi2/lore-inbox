Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267344AbUIUORl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267344AbUIUORl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 10:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267592AbUIUORl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 10:17:41 -0400
Received: from atlrel8.hp.com ([156.153.255.206]:53677 "EHLO atlrel8.hp.com")
	by vger.kernel.org with ESMTP id S267344AbUIUORj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 10:17:39 -0400
Subject: Re: [PATCH/RFC] exposing ACPI objects in sysfs
From: Alex Williamson <alex.williamson@hp.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040921122428.GB2383@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi>
	 <20040921122428.GB2383@elf.ucw.cz>
Content-Type: text/plain
Organization: LOSL
Date: Tue, 21 Sep 2004 08:18:05 -0600
Message-Id: <1095776285.6307.0.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.94.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-09-21 at 14:24 +0200, Pavel Machek wrote:
> Hi!
> 
> >    I've lost track of how many of these patches I've done, but here's
> > the much anticipated next revision ;^)  The purpose of this patch is to
> > expose ACPI objects in the already existing namespace in sysfs
> > (/sys/firmware/acpi/namespace/ACPI).  There's a lot of information
> 
> Perhaps this needs some description in Documentation/ ?
> 

   Yes, definitely.  I'll work on some.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab


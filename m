Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267612AbUIUMYn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267612AbUIUMYn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 08:24:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267614AbUIUMYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 08:24:43 -0400
Received: from gprs214-92.eurotel.cz ([160.218.214.92]:27779 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S267612AbUIUMYm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 08:24:42 -0400
Date: Tue, 21 Sep 2004 14:24:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alex Williamson <alex.williamson@hp.com>
Cc: acpi-devel <acpi-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] exposing ACPI objects in sysfs
Message-ID: <20040921122428.GB2383@elf.ucw.cz>
References: <1095716476.5360.61.camel@tdi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095716476.5360.61.camel@tdi>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>    I've lost track of how many of these patches I've done, but here's
> the much anticipated next revision ;^)  The purpose of this patch is to
> expose ACPI objects in the already existing namespace in sysfs
> (/sys/firmware/acpi/namespace/ACPI).  There's a lot of information

Perhaps this needs some description in Documentation/ ?

								Pavel	
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

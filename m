Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265034AbTFCOsZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 10:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265036AbTFCOsZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 10:48:25 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:44531 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S265034AbTFCOsY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 10:48:24 -0400
Subject: Re: system clock speed too high?
From: Martin Schlemmer <azarah@gentoo.org>
To: Andreas Haumer <andreas@xss.co.at>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EDCAF61.3060202@xss.co.at>
References: <3EDBA83B.5050406@xss.co.at>
	 <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk>
	 <3EDC7052.9060109@xss.co.at> <3EDC8DC0.7090009@xss.co.at>
	 <3EDC96EA.5020906@xss.co.at>
	 <1054645247.9359.12.camel@dhcp22.swansea.linux.org.uk>
	 <3EDCAF61.3060202@xss.co.at>
Content-Type: text/plain
Organization: 
Message-Id: <1054651781.5268.66.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 03 Jun 2003 16:49:41 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 16:23, Andreas Haumer wrote:

> The "USB legacy support" settings slipped through when
> I was preparing the system. I was too much concentrated
> on the ACPI/Fusion MPT problems...
> 
> But something must be wrong in this area, as the kernel prints
> this "..MP-BIOS bug: 8254 timer not connected to IO-APIC"
> message when USB legacy support is disabled.
> 
> Anyway, I'll have this system available for tests in the
> next few days (it is to be installed as production server
> next week), and it _will_ suffer a lot from the stress tests
> I've planned... ;-)
> 
> So if you want me to test anything (ACPI patches, perhaps?)
> you're very welcome!
> 

What about contacting the manufacturer to fix the bios ?


Regards,

-- 
Martin Schlemmer



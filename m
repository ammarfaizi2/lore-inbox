Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263683AbUDUUYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263683AbUDUUYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 16:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUDUUYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 16:24:19 -0400
Received: from fmr99.intel.com ([192.55.52.32]:37776 "EHLO
	hermes-pilot.fm.intel.com") by vger.kernel.org with ESMTP
	id S263683AbUDUUYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 16:24:18 -0400
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
	for idle=C1halt, 2.6.5
From: Len Brown <len.brown@intel.com>
To: Craig Bradney <cbradney@zip.com.au>
Cc: ross@datscreative.com.au, christian.kroener@tu-harburg.de,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Jamie Lokier <jamie@shareable.org>,
       "Prakash K. Cheemplavam" <PrakashKC@gmx.de>,
       Daniel Drake <dan@reactivated.net>, Ian Kumlien <pomac@vapor.com>,
       Jesse Allen <the3dfxdude@hotmail.com>, a.verweij@student.tudelft.nl,
       Allen Martin <AMartin@nvidia.com>
In-Reply-To: <1082063090.4814.20.camel@amilo.bradney.info>
References: <200404131117.31306.ross@datscreative.com.au>
	 <200404131703.09572.ross@datscreative.com.au>
	 <1081893978.2251.653.camel@dhcppc4>
	 <200404160110.37573.ross@datscreative.com.au>
	 <1082060255.24425.180.camel@dhcppc4>
	 <1082063090.4814.20.camel@amilo.bradney.info>
Content-Type: text/plain
Organization: 
Message-Id: <1082578957.16334.13.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Apr 2004 16:22:37 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-15 at 17:04, Craig Bradney wrote:

> > While I don't want to get into the business of maintaining
> > a dmi_scan entry for every system with this issue, I think
> > it might be a good idea to add a couple of example entries
> > for high volume systems for which there is no BIOS fix available.
> > 
> > Got any opinions on which system to use as the example?
> > I'll need the output from dmidecode for them.
> 
> I have an A7N8X Deluxe v2 BIOS v1007 that I can give u whatever numbers
> u need. IOAPIC and APIC are on.

Please send me the output from dmidecode, available in /usr/sbin/, or
here:
http://www.nongnu.org/dmidecode/
or
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

thanks,
-Len



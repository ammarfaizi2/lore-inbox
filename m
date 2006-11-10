Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932601AbWKJJpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932601AbWKJJpd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 04:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932635AbWKJJpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 04:45:31 -0500
Received: from gate.crashing.org ([63.228.1.57]:19121 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932601AbWKJJpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 04:45:30 -0500
Subject: Re: [PATCH 0/2] Add dev_sysdata and use it for ACPI
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg KH <greg@kroah.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20061110054846.GA9137@kroah.com>
References: <1163033121.28571.792.camel@localhost.localdomain>
	 <20061109170435.07d2e0c4@gondolin.boeblingen.de.ibm.com>
	 <1163111737.4982.40.camel@localhost.localdomain>
	 <20061110054846.GA9137@kroah.com>
Content-Type: text/plain
Date: Fri, 10 Nov 2006 20:44:15 +1100
Message-Id: <1163151855.4982.153.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Sorry, I'm in Japan this week, and access to email is limited.
> 
> I like this change, but I like the dev_archdata name better.  It lets
> people know who owns the pointer much better.
> 
> Care to respin these patches with this change?

Ok, changing that should be trivial, I'll send new patches tomorrow.

> And yes, I don't see a problem with such a change like this for 2.6.20,
> it's pretty simple.

Excellent, thanks, Hope your trip was good

(I loved the food last time I was in Tokyo :-)

Cheers,
Ben.



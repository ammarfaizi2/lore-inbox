Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030248AbWHXDbu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030248AbWHXDbu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 23:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030247AbWHXDbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 23:31:50 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:63384 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030235AbWHXDbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 23:31:49 -0400
Message-ID: <44ED1D93.3020203@tw.ibm.com>
Date: Thu, 24 Aug 2006 11:31:31 +0800
From: Albert Lee <albertcc@tw.ibm.com>
Reply-To: albertl@mail.com
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       Jeff Garzik <jgarzik@pobox.com>, Doug Maxey <dwm@enoyolf.org>,
       Unicorn Chang <uchang@tw.ibm.com>
Subject: Re: Merging libata PATA support into the base kernel
References: <1155144599.5729.226.camel@localhost.localdomain>
In-Reply-To: <1155144599.5729.226.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Jeff (rightly) thinks the plan should be discussed publically, so here
> is the plan
> 
> For 2.6.19 to move the libata drivers to drivers/ata
> Add a subset of the new PATA drivers living in -mm to the base kernel
> 

Is it planned for the pata_pdc2027x driver to be included in the
subset of upstream PATA drivers? It would be nice to have the driver
for the adapter hotplug on ppc64.

Thanks,

Albert


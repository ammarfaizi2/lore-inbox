Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261594AbVF2IWz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261594AbVF2IWz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 04:22:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbVF2IWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 04:22:54 -0400
Received: from [85.8.12.41] ([85.8.12.41]:27577 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S261594AbVF2IWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 04:22:50 -0400
Message-ID: <42C25A3A.1070206@drzeus.cx>
Date: Wed, 29 Jun 2005 10:22:18 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kylene Jo Hall <kjhall@us.ibm.com>
CC: Chris Wright <chrisw@osdl.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       tpmdd-devel@lists.sourceforge.net
Subject: Re: 2.6.12 breaks 8139cp [PATCH 1 of 2]
References: <42BA69AC.5090202@drzeus.cx>	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>	 <42C0EE1A.9050809@drzeus.cx> <42C1434F.2010003@drzeus.cx>	 <1119967788.6382.7.camel@localhost.localdomain>	 <42C16162.2070208@drzeus.cx>	 <1119971339.6382.18.camel@localhost.localdomain>	 <20050628172300.GE9153@shell0.pdx.osdl.net>	 <1119990572.6403.8.camel@localhost.localdomain>	 <20050628203408.GA9046@shell0.pdx.osdl.net> <1119996659.6403.14.camel@localhost.localdomain>
In-Reply-To: <1119996659.6403.14.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall wrote:

>
>Here is the patch that should fix the problem.  Pierre can you remove
>the first patch I sent and test this one?
>
>  
>

Apart from an improperly closed enum the patch worked fine. Great work!

Rgds
Pierre


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262155AbVF1Qy0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbVF1Qy0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:54:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVF1QyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:54:08 -0400
Received: from [85.8.12.41] ([85.8.12.41]:18105 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S262127AbVF1Qvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:51:47 -0400
Message-ID: <42C18022.2010101@drzeus.cx>
Date: Tue, 28 Jun 2005 18:51:46 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 1.0.2-7 (X11/20050623)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kylene Jo Hall <kjhall@us.ibm.com>
CC: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, tpmdd-devel@lists.sourceforge.net
Subject: Re: 2.6.12 breaks 8139cp
References: <42B9D21F.7040908@drzeus.cx>	 <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>	 <42C0EE1A.9050809@drzeus.cx>  <42C1434F.2010003@drzeus.cx>	 <1119967788.6382.7.camel@localhost.localdomain>	 <42C16162.2070208@drzeus.cx> <1119971339.6382.18.camel@localhost.localdomain>
In-Reply-To: <1119971339.6382.18.camel@localhost.localdomain>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kylene Jo Hall wrote:

>>You wouldn't happen to have just your patches available?
>>    
>>
>
>Here is the tpm portion of -mm patch
>
>  
>

Thanks. I've tried the patch and everthing seems to work fine now. :)

(btw. does no output in dmesg mean that no TPM chip was found? it seems
to have found a pci id it likes atleast.)

Rgds
Pierre

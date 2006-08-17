Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWHQMnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWHQMnu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932468AbWHQMnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:43:50 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:60586 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932188AbWHQMnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:43:49 -0400
Message-ID: <44E46481.6000408@garzik.org>
Date: Thu, 17 Aug 2006 08:43:45 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Greg KH <greg@kroah.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/75] pci_module_init to pci_register_driver	conversion
References: <20060817042634.0.CrzcY28443.28439.michal@ltg01-fedora.pl>	 <20060817055814.GA14950@kroah.com>  <44E46280.2020109@garzik.org> <1155818266.4494.59.camel@laptopd505.fenrus.org>
In-Reply-To: <1155818266.4494.59.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
>> But it is most definitely not 2.6.18-rc material :)
> 
> that part of it isn't.. marking it deprecated so that people doing new
> code get a warning probably IS 2.6.18, the sooner that happens the
> better....

I disagree.  With all the cleanups going into 2.6.19, that would just 
introduce needless build noise into 2.6.18.

	Jeff




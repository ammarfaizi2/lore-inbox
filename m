Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932493AbWHQNZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbWHQNZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 09:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932491AbWHQNZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 09:25:29 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:64683 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932493AbWHQNZ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 09:25:28 -0400
Message-ID: <44E46E45.5010704@garzik.org>
Date: Thu, 17 Aug 2006 09:25:25 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/75] pci_module_init to pci_register_driver conversion
References: <20060817042634.0.CrzcY28443.28439.michal@ltg01-fedora.pl>	 <20060817055814.GA14950@kroah.com> <44E46280.2020109@garzik.org> <6bffcb0e0608170609g3926cad7wd3b4737d869ed794@mail.gmail.com>
In-Reply-To: <6bffcb0e0608170609g3926cad7wd3b4737d869ed794@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I stand corrected:  netdev-2.6.git#upstream does not contain a 
pci_register_driver() patch.

Send the drivers/net piece along to me and I'll apply it.

	Jeff




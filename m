Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbWHQMiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbWHQMiR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 08:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWHQMiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 08:38:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57571 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932358AbWHQMiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 08:38:15 -0400
Subject: Re: [RFC][PATCH 0/75] pci_module_init to pci_register_driver
	conversion
From: Arjan van de Ven <arjan@infradead.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: Greg KH <greg@kroah.com>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <44E46280.2020109@garzik.org>
References: <20060817042634.0.CrzcY28443.28439.michal@ltg01-fedora.pl>
	 <20060817055814.GA14950@kroah.com>  <44E46280.2020109@garzik.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 17 Aug 2006 14:37:46 +0200
Message-Id: <1155818266.4494.59.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> But it is most definitely not 2.6.18-rc material :)

that part of it isn't.. marking it deprecated so that people doing new
code get a warning probably IS 2.6.18, the sooner that happens the
better....



-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com


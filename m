Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVA1Jdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVA1Jdv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 04:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261241AbVA1Jdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 04:33:51 -0500
Received: from tartu.cyber.ee ([193.40.6.68]:30216 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id S261242AbVA1JdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 04:33:09 -0500
From: Meelis Roos <mroos@linux.ee>
To: sfeldma@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: [ANN] removal of certain net drivers coming soon: eepro100,?xircom_tulip_cb, iph5526
In-Reply-To: <1106877517.18167.311.camel@localhost.localdomain>
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.11-rc2 (i686))
Message-Id: <E1CuSUy-00063X-LK@rhn.tartu-labor>
Date: Fri, 28 Jan 2005 11:33:04 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eepro100 also drives 82556-based cards. I have a couple of EtherExpress
PRO/100 Smart cards, Intel identifier is PILA8485, PCI ID is 8086:1228.
e100 doesn't support them, I'm told eepro100 works (I have not verified
it myself). I can probably get a card or to for testing with Linux.

-- 
Meelis Roos

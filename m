Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271819AbTG2POs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271822AbTG2POs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:14:48 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:30193 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271819AbTG2POr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:14:47 -0400
Subject: Re: [REPOST] "apm: suspend: Unable to enter requested state" after
	 2.5.31 (incl. 2.6.0testX)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Charles Lepple <clepple@ghz.cc>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sfr@canb.auug.org.au
In-Reply-To: <28705.216.12.38.216.1059490232.squirrel@www.ghz.cc>
References: <28705.216.12.38.216.1059490232.squirrel@www.ghz.cc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059491223.6094.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 16:07:04 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does it work any better if you change the 0x0, 0x00409200 to

0x00109300, 0x00409200 ?


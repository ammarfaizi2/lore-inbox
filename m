Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264611AbTFELO3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264612AbTFELO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:14:28 -0400
Received: from pizda.ninka.net ([216.101.162.242]:23009 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264611AbTFELO2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:14:28 -0400
Date: Thu, 05 Jun 2003 04:25:37 -0700 (PDT)
Message-Id: <20030605.042536.41633837.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jgarzik@pobox.com, margitsw@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: PCI cache line messages 2.4/2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1054812011.15276.37.camel@dhcp22.swansea.linux.org.uk>
References: <1054809554.15276.8.camel@dhcp22.swansea.linux.org.uk>
	<1054811157.19407.3.camel@rth.ninka.net>
	<1054812011.15276.37.camel@dhcp22.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 05 Jun 2003 12:20:12 +0100
   
   And then there is hotplug
   
My understanding is that the bioses do the cacheline, irq,
etc. assignment via BIOS callbacks done by the PCI controller hotplug
driver.


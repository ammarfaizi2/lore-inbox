Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265300AbTFFFAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 01:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265302AbTFFFAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 01:00:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48359 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265300AbTFFFAK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 01:00:10 -0400
Date: Thu, 05 Jun 2003 22:11:08 -0700 (PDT)
Message-Id: <20030605.221108.78711828.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: jgarzik@pobox.com, margitsw@t-online.de, linux-kernel@vger.kernel.org
Subject: Re: PCI cache line messages 2.4/2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1054842521.15275.45.camel@dhcp22.swansea.linux.org.uk>
References: <1054812011.15276.37.camel@dhcp22.swansea.linux.org.uk>
	<20030605.042536.41633837.davem@redhat.com>
	<1054842521.15275.45.camel@dhcp22.swansea.linux.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: 05 Jun 2003 20:48:42 +0100

   On Iau, 2003-06-05 at 12:25, David S. Miller wrote:
   > My understanding is that the bioses do the cacheline, irq,
   > etc. assignment via BIOS callbacks done by the PCI controller hotplug
   > driver.
   
   Ah cloud cuckoo land 8)
   
First, can I get some english without the welsh grammar? :-)
Second, BIOS callbacks are exactly what I see the compaq hotplug
PCI driver doing.

   Come on down Dave ;)
   
:)

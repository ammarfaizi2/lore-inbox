Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbTICLvh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 07:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbTICLvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 07:51:37 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:30923 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261938AbTICLvg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 07:51:36 -0400
Subject: Re: What is the SiI 0680 chipset status?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tomasz =?ISO-8859-1?Q?B=B1tor?= <tomba@bartek.tu.kielce.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030902165537.GA1830@bartek.tu.kielce.pl>
References: <20030902165537.GA1830@bartek.tu.kielce.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1062589779.19059.8.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-4) 
Date: Wed, 03 Sep 2003 12:49:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-09-02 at 17:55, Tomasz B±tor wrote:
> I recently got MiNt PCI IDE ATA/133 RAID controller based on SiI 0680
> chipset. I browsed through the archives and I know that the driver is
> known to be broken and simply doesn't work.

It just works. You do want 2.4.22 ideally, and you want 2.4.22-ac to use
hotplug.

Alan


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTIVSup (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 14:50:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262117AbTIVSup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 14:50:45 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:21443 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262019AbTIVSul (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 14:50:41 -0400
Subject: Re: SiI3112: problemes with shared interrupt line?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Per Andreas Buer <perbu@linpro.no>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <PERBUMSGID-ul6pthskb16.fsf@ipchains.linpro.no>
References: <PERBUMSGID-ul6pthskb16.fsf@ipchains.linpro.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1064256539.9008.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 19:49:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-09-22 at 18:06, Per Andreas Buer wrote:
> we got a machine with a Nforce2 chipset and a SiI3112 SATA controller.
> Two Maxtor disks are configured in software raid, level 1. 
> 
> The machine is quite stable as long as I keep the raid degraded. If try
> to syncronize the array the machines dies within 20 minutes. No message
> given.

Just about every bug report I have about SI3112 now is on Nforce
chipsets. At the moment however I don't know what the magic connection
is.


Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVJUMEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVJUMEK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 08:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVJUMEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 08:04:10 -0400
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:18057 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964910AbVJUMEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 08:04:09 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Vladimir Lazarenko <vlad@lazarenko.net>
Subject: Re: sata_nv + SMP = broken?
Date: Fri, 21 Oct 2005 14:04:21 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <4358C417.9000608@lazarenko.net>
In-Reply-To: <4358C417.9000608@lazarenko.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510211404.21374.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 21 of October 2005 12:33, Vladimir Lazarenko wrote:
> Hello,
> 
> Yesterday I've tried launching various kernels on Ahtlon64 Dual-core X2 
> 3800+ with MSI Neo4 Platinum SLI motherboard.
> 
> The results were a total catastrophica failure. As soon as I enable SMP 
> in the kernel, the sata driver would randomly hang after a bit of disk 
> activity.

I've been running Linux on Athlon64 X2 w/ Nforce4-based SLI Asus
board (single graphics adapter though) for a couple of months now and
it works just fine.

I'd bet you need to upgrade the BIOS, but if you already have, there's
likely something wrong with the mainboard.

Greetings,
Rafael

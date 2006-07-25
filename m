Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964785AbWGYSN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWGYSN4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWGYSN4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:13:56 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30664 "EHLO
	out.lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S964785AbWGYSN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:13:56 -0400
Subject: Re: Debugging APM - cat /proc/apm produces oops
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200607231630.53968.linux@rainbow-software.org>
References: <200607231630.53968.linux@rainbow-software.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 25 Jul 2006 20:15:21 +0100
Message-Id: <1153854921.4725.22.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2006-07-23 at 16:30 +0200, Ondrej Zary wrote:
> Hello,
> cat /proc/apm produces oops on my DTK notebook. Using "apm=broken-psr" kernel 
> parameter fixes that but I lose the battery info. I'd like to have the 
> battery info (and it works fine in Windows) so I want to debug it and 
> (hopefully) fix.

If broken-psr is needed can you also send me a dmidecode and lspci -vxx
dump so I can automate that bit.

Alan


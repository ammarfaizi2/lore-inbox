Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030499AbWKTXdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030499AbWKTXdg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030511AbWKTXdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:33:36 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:54167 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030507AbWKTXde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:33:34 -0500
Date: Mon, 20 Nov 2006 23:31:53 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, jgarzik@pobox.com, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, jejb@steeleye.com
Subject: Re: [RFC: 2.6 patch] remove the broken SKMC driver
Message-ID: <20061120233153.34bd814d@localhost.localdomain>
In-Reply-To: <20061120140115.4cdec66a@freekitty>
References: <20061120210648.GB31879@stusta.de>
	<20061120140115.4cdec66a@freekitty>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2006 14:01:15 -0800
Stephen Hemminger <shemminger@osdl.org> wrote:

> Are there any working microchannel drivers?  Can we drop support for microchannel
> at the bus level?

Mr Bottomley has MCA bus. I don't think anyone else on the planet cares
so maybe we should drop all non voyager MCA bus support and make MCA
depend on VOYAGER ?

Alan

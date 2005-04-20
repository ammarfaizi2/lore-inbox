Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261833AbVDTWYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261833AbVDTWYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 18:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261834AbVDTWYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 18:24:04 -0400
Received: from mailrelay1.bredband.net ([195.54.107.81]:22177 "EHLO
	mailrelay1.bredband.net") by vger.kernel.org with ESMTP
	id S261833AbVDTWYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 18:24:02 -0400
From: Gabriel =?ISO-8859-1?Q?J=E4genstedt?= <gabriel.j@telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Booting from USB with initrd
Message-ID: <20050421002401.56675e0a@insula.localdomain>
In-Reply-To: <1113810484.5418.36.camel@FC3-bernhard-1.acousta.local>
References: <420333.1113682535160.JavaMail.root@pne-ps2-sn1>
	<1113810484.5418.36.camel@FC3-bernhard-1.acousta.local>
X-Mailer: Sylpheed-Claws 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 21 Apr 2005 00:24:38 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cheers!

Everythings up and running now. It had nothing to do with the kernel and
all to do with a wrong word in syslinux.cfg.
I had the wrong default set so it defaulted to running the kernel
without options. Which is no good idea when booting an initrd =)

Thanks for the help anyhow.

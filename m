Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262799AbTIEWpX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 18:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262854AbTIEWpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 18:45:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:39597 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262799AbTIEWpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 18:45:21 -0400
Date: Fri, 5 Sep 2003 15:28:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: adq_dvb@lidskialf.net, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net, linux-acpi@intel.com
Subject: Re: [ACPI] Re: [PATCH] Next round of ACPI IRQ fixes (VIA ACPI
 fixed)
Message-Id: <20030905152805.521281b6.akpm@osdl.org>
In-Reply-To: <3F590E28.6090101@pobox.com>
References: <200309051958.02818.adq_dvb@lidskialf.net>
	<3F59018E.5060604@pobox.com>
	<200309060016.16545.adq_dvb@lidskialf.net>
	<3F590E28.6090101@pobox.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> Many of us have patch-applying scripts,

But only one of us documented them ;)

	http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.12/

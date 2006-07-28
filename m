Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161095AbWG1TY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161095AbWG1TY5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWG1TY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:24:57 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15016 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030286AbWG1TY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:24:56 -0400
Date: Fri, 28 Jul 2006 12:24:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: linux-kernel@vger.kernel.org, dsd@gentoo.org, alan@lxorguk.ukuu.org.uk,
       cw@f00f.org, greg@kroah.com, jeff@garzik.org, harmon@ksu.edu
Subject: Re: [PATCH] VIA IRQ quirk fixup only in XT_PIC mode Take 2
Message-Id: <20060728122405.02305b69.akpm@osdl.org>
In-Reply-To: <1154091662.7200.9.camel@localhost.localdomain>
References: <1154091662.7200.9.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 14:01:01 +0100
Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> wrote:

> Hi, this patch (now for 2.6.18-rc2) is more readable.

It has no changelog, and this sort of patch does need a lenghty one, please.

What relationship does it have to
ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc2/2.6.18-rc2-mm1/broken-out/pci-quirk_via_irq-behaviour-change.patch?
 If it is better, why?

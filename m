Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbVCRQYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbVCRQYO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 11:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVCRQYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 11:24:09 -0500
Received: from [81.2.110.250] ([81.2.110.250]:32701 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261611AbVCRQXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 11:23:40 -0500
Subject: Re: [PATCH] DM9000 network driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050318133143.GA20838@metis.extern.pengutronix.de>
References: <20050318133143.GA20838@metis.extern.pengutronix.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1111162885.9874.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 18 Mar 2005 16:21:30 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-03-18 at 13:31, Sascha Hauer wrote:
> Hello all,
> 
> This patch adds support for the davicom dm9000 network driver. The
> dm9000 is found on some embedded arm boards such as the pimx1 or the
> scb9328.

Unless I'm missing something its just yet another NE2000 (ie 8390) clone
and can used the 8390 core or maybe even ne2k-pci  ?


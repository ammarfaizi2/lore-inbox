Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWIDQZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWIDQZK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWIDQZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:25:09 -0400
Received: from relay5.ptmail.sapo.pt ([212.55.154.25]:11445 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S964926AbWIDQZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:25:06 -0400
X-AntiVirus: PTMail-AV 0.3-0.88.4
Subject: Re: VIA IRQ quirk fixup only in XT-PIC mode Take 3
From: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bjorn.helgaas@hp.com, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wedgwood <cw@f00f.org>,
       greg@kroah.com, jeff@garzik.org, harmon@ksu.edu,
       Daniel Drake <dsd@gentoo.org>, Len Brown <len.brown@intel.com>
In-Reply-To: <20060903175841.7a84c63c.akpm@osdl.org>
References: <1157330567.3046.24.camel@localhost.portugal>
	 <20060903175841.7a84c63c.akpm@osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Mon, 04 Sep 2006 17:25:09 +0100
Message-Id: <1157387109.2578.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-03 at 17:58 -0700, Andrew Morton wrote:
> There's a similar patch in -mm:
> pci-quirk_via_irq-behaviour-change.patch. 
> Does that work for you? 

For me, the problem is not if it work or not. 
For the same VIA IDs, sometimes we need quirk and other times not.

Thanks, 
--
Sérgio M. B. 


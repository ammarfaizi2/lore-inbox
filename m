Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750796AbWFEQlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750796AbWFEQlP (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 12:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWFEQlO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 12:41:14 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:659 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S1750742AbWFEQlN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 12:41:13 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: sergio@sergiomb.no-ip.org
Subject: Re: back to discussion of VIA quirk fixup
Date: Mon, 5 Jun 2006 10:41:06 -0600
User-Agent: KMail/1.8.3
Cc: linux-acpi@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>
References: <1148433146.2885.41.camel@localhost.portugal>
In-Reply-To: <1148433146.2885.41.camel@localhost.portugal>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200606051041.06738.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 May 2006 19:12, Sergio Monteiro Basto wrote:
> 1º This quirk_via_irq function has been created originally by Bjorn
> Helgaas, so maybe he can tell better what patch does.

I didn't really create the function, I merely renamed it and
tweaked it a bit based on some bug reports.  And I've never been
able to match up this quirk with any VIA chipset documentation,
so I vowed never to get involved with it again :-)

Bjorn


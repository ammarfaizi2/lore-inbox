Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267474AbUHJP7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267474AbUHJP7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 11:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267480AbUHJP7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 11:59:39 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:25988 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S267474AbUHJP7c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 11:59:32 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: 2.6.8-rc4-mm1 doesn't boot
Date: Tue, 10 Aug 2004 09:59:18 -0600
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040810002110.4fd8de07.akpm@osdl.org> <20040810150859.GO26174@fs.tum.de>
In-Reply-To: <20040810150859.GO26174@fs.tum.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408100959.18903.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 August 2004 9:09 am, Adrian Bunk wrote:
> 2.6.8-rc3-mm1 boots fine on my computer.
> 2.6.8-rc4-mm1 doesn't boot.
> 2.6.8-rc4-mm1 with pci=routeirq boots.

Thanks for the report.  Can you send me the output of "lspci" and
your .config file?  I don't see any obvious problems with the drivers
I see mentioned in the boot log, but it would be easier if I knew
exactly which drivers to look at.

Bjorn


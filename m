Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVA1S70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVA1S70 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262747AbVA1S4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:56:39 -0500
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:22999 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262701AbVA1SyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:54:06 -0500
Date: Fri, 28 Jan 2005 19:54:02 +0100
From: Michael Gernoth <simigern@stud.uni-erlangen.de>
To: Bukie Mabayoje <bukiemab@gte.net>
Cc: linux-kernel@vger.kernel.org,
       Matthias Koerber <simakoer@stud.informatik.uni-erlangen.de>
Subject: Re: 2.4.29, e100 and a WOL packet causes keventd going mad
Message-ID: <20050128185402.GA7923@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Bukie Mabayoje <bukiemab@gte.net>,
	linux-kernel@vger.kernel.org,
	Matthias Koerber <simakoer@stud.informatik.uni-erlangen.de>
References: <20050128164811.GA8022@cip.informatik.uni-erlangen.de> <41FA8A3F.CC19F9EE@gte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41FA8A3F.CC19F9EE@gte.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 10:53:51AM -0800, Bukie Mabayoje wrote:
> Do you know the official NIC product name e.g Pro/100B. I need to identify
> the LAN Controller. There are differences between  557 (not sure if 557 can
> do WOL), 558 and 559 how they ASSERT the PME# signal. Even the same chip have
> differences between steppings.

The chip is integrated on the motherboard. Its PCI ID is 8086:1039.
lspci says: Intel Corp. 82801BD PRO/100 VE (LOM) Ethernet Controller (rev 81)
If you want I can open up one of these machines tomorrow to look on the chip
directly.

Regards,
  Michael

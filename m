Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265435AbTLHPeP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 10:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265439AbTLHPeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 10:34:15 -0500
Received: from fmr04.intel.com ([143.183.121.6]:58347 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S265435AbTLHPeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 10:34:11 -0500
Subject: Re: Hyperthreading - Found the answers
From: Len Brown <len.brown@intel.com>
To: dean gaudet <dean-list-linux-kernel@arctic.org>
Cc: "Russell \"Elik\"  " Rademacher <elik@webspires.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE00184D503@hdsmsx402.hd.intel.com>
References: <BF1FE1855350A0479097B3A0D2A80EE00184D503@hdsmsx402.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1070897643.2551.19.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 08 Dec 2003 10:34:03 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-12-07 at 13:03, dean gaudet wrote:

> fwiw, on my xeon box i need to use "acpi=ht" or else the acpi code
> causes
> 80000 interrupts per second, even when idle.  (this is with 2.4.22, on
> a
> tyan 2723 with whatever their latest bios was as of three or four
> months
> ago.)

I'm interested to know if you still have an ACPI interrupt issue when
running the latest ACPI code, say running 2.4.23 or ACPI patch to
2.4.22:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/release/2.4.22/

thanks,
-Len



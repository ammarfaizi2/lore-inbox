Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263573AbTE3Kw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 06:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263574AbTE3Kw6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 06:52:58 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59096
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263573AbTE3Kw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 06:52:57 -0400
Subject: Re: Asrock K7S8X Motherboard kernel problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David R. Wilson" <david@wwns.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200305292117.h4TLHMj07604@wwns.wwns.com>
References: <200305292117.h4TLHMj07604@wwns.wwns.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054289302.23566.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 30 May 2003 11:08:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-05-29 at 22:17, David R. Wilson wrote:
> Problem with booting disappeared when I changed to NOAPIC in the
> .config file.
> 
> Thanks for the help fellows!

SiS APIC should work in 2.4.21-pre5-ac2 and later or in 2.5.x although
thats by no means certain for all cases yet 8)


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270214AbTHGQJk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 12:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265591AbTHGQJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 12:09:39 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:41092 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S270350AbTHGP7L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 11:59:11 -0400
Subject: Re: Loading Pentium III microcode under Linux - catch 22!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Chris Rankin <rankincj@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0308071651340.12315-100000@einstein31.homenet>
References: <Pine.LNX.4.44.0308071651340.12315-100000@einstein31.homenet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1060271725.3168.79.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Aug 2003 16:55:25 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-07 at 16:57, Tigran Aivazian wrote:
> I could implement this, but if you tell me that this is not allowed
> because of the GPL issues (microcode data chunks are copyrighted by Intel)
> then obviously I won't waste time writing the code to do this.

Thats something we are moving away from, so that we can load firmware
from the initrd. Another interesting place to tackle it might be in lilo
or grub ?


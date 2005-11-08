Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbVKHNr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbVKHNr3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 08:47:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVKHNr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 08:47:29 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38572 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964939AbVKHNr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 08:47:28 -0500
Subject: Re: Automatic download of kernel rpms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200511080833.57710.gene.heskett@verizon.net>
References: <20051108062936.14482.qmail@web33308.mail.mud.yahoo.com>
	 <200511080833.57710.gene.heskett@verizon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Nov 2005 14:18:23 +0000
Message-Id: <1131459503.25192.42.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-08 at 08:33 -0500, Gene Heskett wrote:
> Generally, no.  The exact reason is that rpms are a vendor item, and no
> fixed relation to the kernel.org tarballs.

"make rpm" should build an RPM package from them but you will still need
to get the configuration correct before doing this.


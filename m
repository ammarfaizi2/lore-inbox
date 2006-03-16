Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWCPPL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWCPPL6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 10:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbWCPPL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 10:11:58 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:28350 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751320AbWCPPL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 10:11:57 -0500
Subject: Re: VMI Interface Proposal Documentation for I386, Part 4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060315233703.GE1919@elf.ucw.cz>
References: <4415CE1C.1060608@vmware.com> <20060315233703.GE1919@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 16 Mar 2006 15:18:28 +0000
Message-Id: <1142522308.13318.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-03-16 at 00:37 +0100, Pavel Machek wrote:
> This code used to work when ran as root:

Unless it page faulted, or was on SMP, or ....

> I'm not sure how will X like this.

X has not used this ability for many years.

Alan


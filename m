Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272359AbTHIOEi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 10:04:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272362AbTHIOEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 10:04:38 -0400
Received: from [66.212.224.118] ([66.212.224.118]:48136 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S272359AbTHIOEh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 10:04:37 -0400
Date: Sat, 9 Aug 2003 09:52:48 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
X-X-Sender: zwane@montezuma.mastecende.com
To: Thomas Molina <tmolina@cablespeed.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 973] Re: Linux 2.6.0-test3:  Presario laptop panic
In-Reply-To: <Pine.LNX.4.44.0308090945150.2587-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0308090952200.32166@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0308090945150.2587-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 Aug 2003, Thomas Molina wrote:

> Please see Bugzilla for the gory details.  Synopsis is that my Preario 
> laptop panics on boot:
> 
> Unable to handle kernel pagin request at virtual address c035800
> 
> EIP 0060:[<c014CE95>]
> EIP is at store_stackinfo+0x85/0xc0
> 
> This behaviour continues since 2.5.74-bk1.  

Thanks for the update, i'll debug it during the course of the weekend.

	Zwane


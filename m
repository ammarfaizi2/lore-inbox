Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264734AbUEJPLN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264734AbUEJPLN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 11:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264737AbUEJPLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 11:11:13 -0400
Received: from fw.osdl.org ([65.172.181.6]:1257 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264734AbUEJPLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 11:11:11 -0400
Date: Mon, 10 May 2004 08:11:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniele Venzano <webvenza@libero.it>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.6
In-Reply-To: <20040510105129.GB25969@picchio.gall.it>
Message-ID: <Pine.LNX.4.58.0405100810320.3028@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405091954240.3028@ppc970.osdl.org>
 <20040510105129.GB25969@picchio.gall.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 10 May 2004, Daniele Venzano wrote:
> 
> Attached dmesg for 2.6.5 and .config for 2.6.6

Can you do the dmesg for 2.6.6 too? Just to see if something else changed? 
For example, maybe ACPI or something decided to (incorrectly) change your 
irq..

		Linus

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262837AbUFWXzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262837AbUFWXzN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263041AbUFWXzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:55:13 -0400
Received: from supreme.pcug.org.au ([203.10.76.34]:30359 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262837AbUFWXzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:55:11 -0400
Date: Thu, 24 Jun 2004 09:54:49 +1000 (EST)
From: Stephen Rothwell <sfr@canb.auug.org.au>
Message-Id: <200406232354.i5NNsnCL029470@supreme.pcug.org.au>
To: greg@kroah.com, jeremy.katz@gmail.com
Cc: akpm@osdl.org, jgarzik@pobox.com, katzj@redhat.com,
       linux-kernel@vger.kernel.org, sfr@canb.auug.org.au, torvalds@osdl.org
Subject: Re: [PATCH] PPC64 iSeries viodasd proc file
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Greg KH <greg@kroah.com>
> 
> I agree, I don't think that many things have disappeared from /proc just
> yet, right?  You should just have more information than what you
> previously did, right?  Or did scsi drop their /proc support fully?

What started this discussion is that I had to drop all the proc support
from the iSeries virtual devices while attempting to get the drivers
into the mainline kernel.

Cheers,
Stephen

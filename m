Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUCDO7U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 09:59:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261924AbUCDO7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 09:59:20 -0500
Received: from math.ut.ee ([193.40.5.125]:40649 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261918AbUCDO6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 09:58:21 -0500
Date: Thu, 4 Mar 2004 16:58:17 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Brian Gerst <bgerst@didntduck.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.3: PnPBIOS hangs with S875WP1 BIOS
In-Reply-To: <40474101.8040306@didntduck.org>
Message-ID: <Pine.GSO.4.44.0403041657430.10910-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > PNPBIOS fault.. attempting recovery.
> > double fault, gdt at c0488100 [255 bytes]
> > double fault, tss at c0530800
> > eip = f7fa1ea6, esp = 00000028
>
> Looks like the BIOS trashed the stack.  I don't think there is anything
> that can be done other than a BIOS update.

This is the latest BIOS (P12) so I reported it to Intel.

-- 
Meelis Roos (mroos@linux.ee)


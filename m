Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266035AbUFPAiM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266035AbUFPAiM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 20:38:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbUFPAiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 20:38:12 -0400
Received: from conure.mail.pas.earthlink.net ([207.217.120.54]:26758 "EHLO
	conure.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S266035AbUFPAiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 20:38:09 -0400
From: Eric <eric@cisu.net>
Reply-To: eric@cisu.net
To: Christoph Hellwig <hch@lst.de>
Subject: Re: more files with licenses that aren't GPL-compatible
Date: Tue, 15 Jun 2004 19:38:02 -0500
User-Agent: KMail/1.6.2
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
References: <20040615205753.GA24380@lst.de>
In-Reply-To: <20040615205753.GA24380@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406151938.02613.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 June 2004 03:57 pm, Christoph Hellwig wrote:
> While I don't want to jump into the usual Debian wankfest whether Linux
> as GPL'ed project can distribute hex-images of firmware at all there are
> a few firmware C headers files that have a license statement that aren't
> GPL-compatible at all, namely the keyspan firmware in
> drivers/usb/serial/keyspan*_fw.h with the following license text:

--*snip*--

> 	Permission is hereby granted for the distribution of this firmware
> 	image as part of a Linux or other Open Source operating system kernel
> 	in text or binary form as required.

> 	This firmware may not be modified and may only be used with
> 	Keyspan hardware.  Distribution and/or Modification of the
> 	keyspan.c driver which includes this firmware, in whole or in
> 	part, requires the inclusion of this statement."
> ---------------------------- snip ----------------------------
>
> which makes the kernel as whole unredistributable.  A similar license
> was according to Greg also recently granted for
> drivers/usb/misc/emi62_fw_*.h which currently has even worse license
> statements in there.

Unredistributable? Am I mistaken? It says permission is given to redistribute 
this piece as part of the linux kernel. You just can't modify it. Although it 
is unquestionably not a very permissive license, it's inclusion is not 
detrimental to the kernel.

Please correct me if I am wrong.

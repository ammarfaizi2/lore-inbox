Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263039AbTJEJcf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Oct 2003 05:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263049AbTJEJcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Oct 2003 05:32:35 -0400
Received: from zero.aec.at ([193.170.194.10]:52740 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263039AbTJEJce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Oct 2003 05:32:34 -0400
To: Enrico Bartky <info@realdos.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VIA KT600
From: Andi Kleen <ak@muc.de>
Date: Sun, 05 Oct 2003 11:32:27 +0200
In-Reply-To: <D2Ld.6Nu.3@gated-at.bofh.it> (Enrico Bartky's message of "Sun,
 05 Oct 2003 00:10:07 +0200")
Message-ID: <m3pthcav2s.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <D06J.319.5@gated-at.bofh.it> <D1ma.4KX.15@gated-at.bofh.it>
	<D2Ld.6Nu.3@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Enrico Bartky <info@realdos.de> writes:

> Nothing, I try to boot.... with my S-ATA HardDisk. As IDE Driver a
> take the VIA82CXXXX...

VIA82C... isn't a SATA driver.

You would need Jeff Garzik's libata patches. It has a VIA driver in theory.

Unfortunately last time I tested it also didn't work, but that 
was on a different VIA chipset.

-Andi

Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262823AbVAFNp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262823AbVAFNp4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 08:45:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVAFNp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 08:45:56 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:55226 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262823AbVAFNpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 08:45:54 -0500
Subject: Re: 2.6.10-ac3 compile failure
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41DB3733.3060002@eyal.emu.id.au>
References: <41DB3733.3060002@eyal.emu.id.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104940896.17176.188.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 12:41:37 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2005-01-05 at 00:39, Eyal Lebedinsky wrote:
>    CC [M]  drivers/char/agp/intel-agp.o
> drivers/char/agp/intel-agp.c: In function `intel_i915_configure':
> drivers/char/agp/intel-agp.c:640: error: too many arguments to function `writel'
> make[3]: *** [drivers/char/agp/intel-agp.o] Error 1

Already fixed in -ac4. Its one reason -ac3 wasnt publically announced. I
figured I'd get enough mail as it was with that error 


Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263640AbTDDL0H (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263646AbTDDL0H (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:26:07 -0500
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:11473 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263640AbTDDLUF (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 06:20:05 -0500
Subject: Re: 2.5.66-mm3: hang and crash
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: CaT <cat@zip.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030404013732.GA466@zip.com.au>
References: <20030404013732.GA466@zip.com.au>
Content-Type: text/plain
Organization: 
Message-Id: <1049455884.608.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 04 Apr 2003 13:31:25 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-04-04 at 03:37, CaT wrote:
> Just tried mm3 for the fun of it with two results:
> 
> 1. If I leave my Xircom card in the PCMCIA slot, the kernel hangs at the 
>    following point during boot:

It's a know problem... Russell King its working on it. Please, be
patient :-)

For now, you can try removing the card from the PCMCIA slot, booting the
kernel and then, inserting the card.

Thanks!

________________________________________________________________________
Linux Registered User #287198


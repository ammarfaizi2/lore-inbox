Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269320AbVBEOWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269320AbVBEOWb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 09:22:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269341AbVBEOWb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 09:22:31 -0500
Received: from ms004msg.fastwebnet.it ([213.140.2.58]:64686 "EHLO
	ms004msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S269320AbVBEOWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 09:22:24 -0500
Date: Sat, 5 Feb 2005 15:22:34 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Axel Schmalowsky <schmalowsky@mglug.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: L1_CACHE
Message-ID: <20050205152234.2670fdee@tux.homenet>
In-Reply-To: <4204B1D2.9070609@mglug.de>
References: <4204B1D2.9070609@mglug.de>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Feb 2005 11:45:22 +0000
Axel Schmalowsky <schmalowsky@mglug.de> wrote:

> Can anyone tell me if it is destruktive or does it cause lose of 
> performance if I set up
> L1_CACHE_SHIFT_MAX as well as CONFIG_X86_L1_CACHE_SHIFT to the value
> of 10?
> 
> I've an Intel centrino processor with 1MB L1-Cache.

1 MB L1?

Isn't it L2?

-- 
	Paolo Ornati
	Gentoo Linux (kernel 2.6.10-gentoo-r6)

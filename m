Return-Path: <linux-kernel-owner+w=401wt.eu-S964848AbXADNRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbXADNRz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbXADNRz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:17:55 -0500
Received: from aa015msg.fastweb.it ([213.140.2.82]:60050 "EHLO
	aa015msg.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964848AbXADNRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:17:54 -0500
Date: Thu, 4 Jan 2007 14:17:43 +0100
From: Andrea Gelmini <gelma@gelma.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-ID: <20070104131743.GD28470@gelma.net>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net> <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org> <459C8B86.2050905@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C8B86.2050905@yahoo.com.au>
Weight: 77.8 kg (171.51964 lbs)
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 04:07:18PM +1100, Nick Piggin wrote:
> But the patch that Andrea was pointing to was your last patch (The Fix),
> which stopped page_mkclean caller throwing out dirty bits. You probably
> didn't see that in the mail I cc'ed you on.

well, I pointed at that patch for reply, but as I wrote in my first
mail, I was using 2.6.20-rc2-git1.

thank a lot for your time,
gelma

Return-Path: <linux-kernel-owner+w=401wt.eu-S964852AbXADNTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964852AbXADNTS (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbXADNTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:19:18 -0500
Received: from aa016msg.fastweb.it ([213.140.2.83]:49870 "EHLO
	aa016msg.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964852AbXADNTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:19:17 -0500
Date: Thu, 4 Jan 2007 14:19:02 +0100
From: Andrea Gelmini <gelma@gelma.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-ID: <20070104131902.GE28470@gelma.net>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net> <459C7B24.8080008@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C7B24.8080008@yahoo.com.au>
Weight: 77.8 kg (171.51964 lbs)
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 02:57:24PM +1100, Nick Piggin wrote:
> I wouldn't discount a kernel bug, but it will be hard to track down
> unless you can find an earlier kernel that did not cause the corruptions
> and/or provide source for a minimal test case to reproduce.

see my others reply, please.

thanks a lot for your time,
gelma

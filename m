Return-Path: <linux-kernel-owner+w=401wt.eu-S964845AbXADNQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbXADNQY (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 08:16:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964847AbXADNQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 08:16:24 -0500
Received: from aa014msg.fastweb.it ([213.140.2.81]:60566 "EHLO
	aa014msg.fastweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964845AbXADNQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 08:16:24 -0500
Date: Thu, 4 Jan 2007 14:16:12 +0100
From: Andrea Gelmini <gelma@gelma.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
Message-ID: <20070104131612.GC28470@gelma.net>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net> <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net> <459C7B24.8080008@yahoo.com.au> <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org> <20070103214121.997be3e6.akpm@osdl.org> <459C98BF.5080409@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459C98BF.5080409@yahoo.com.au>
Weight: 77.8 kg (171.51964 lbs)
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 05:03:43PM +1100, Nick Piggin wrote:
> Anyway that leaves us with the question of why Andrea's database is getting
> corrupted. Hopefully he can give us a minimal test-case.

yep, I can give you a complete image of my machine, or a root access.
replicate the problem it's not complicated, but it requires some time
(you have to expire/update usenet/newsgroup headers).
I can talk with Bauno to see if he can produce an automated program that
replicate user behavior.

thanks a lot for your interest,
gelma

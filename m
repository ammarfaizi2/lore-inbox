Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262609AbTDQVPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 17:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262620AbTDQVPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 17:15:45 -0400
Received: from [80.190.48.67] ([80.190.48.67]:26387 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262609AbTDQVPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 17:15:44 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Andrew Morton <akpm@digeo.com>, Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [patch] Fix orlov allocator boundary case
Date: Thu, 17 Apr 2003 23:27:09 +0200
User-Agent: KMail/1.5.1
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <20030417111303.706d7246.shemminger@osdl.org> <20030417122142.39d27f73.akpm@digeo.com>
In-Reply-To: <20030417122142.39d27f73.akpm@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304172327.09876.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 17 April 2003 21:21, Andrew Morton wrote:

Hi Andrew,

> OK, here be the fix.
> I'm a bit peeved that this wasn't discovered until it hit Linus's tree.
> Weren't these patches in -mjb as well?
I guess this is also true for the ext3 code?

I am using the orlov stuff for 2.4.21* maintained by Theodore and Steven.

ciao, Marc

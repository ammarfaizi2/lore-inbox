Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265177AbTLROZi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265178AbTLROZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:25:38 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:51448 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S265177AbTLROZd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:25:33 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: Randy Zagar <jrzagar@cactus.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
Date: Thu, 18 Dec 2003 08:24:50 -0600
X-Mailer: KMail [version 1.2]
References: <1071738720.25032.496.camel@otter.zagar.linux-dude.net>
In-Reply-To: <1071738720.25032.496.camel@otter.zagar.linux-dude.net>
MIME-Version: 1.0
Message-Id: <03121808245000.14685@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 December 2003 03:12, Randy Zagar wrote:
[snip]
> p.s.  The first thing I'm going to do after I build my time machine is
> go visit Finland and say "Use the LGPL, Linus".

I believe he did, and he decided the LGPL did not apply since the Kernel is a
"main program", and not really a library.

Now if Linux were converted to a microkernel then things might be different.

Unfortunately, most of the hardware linux runs on doesn't support
the microkernel structure efficently (not enough general registers,
insufficiently fine grained memory address control, uncontroled DMA,
and too much time in context switching...)

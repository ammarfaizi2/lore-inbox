Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265110AbUGGP5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUGGP5u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 11:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265210AbUGGP5t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 11:57:49 -0400
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:51408 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S265110AbUGGP5j
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 11:57:39 -0400
Subject: Re: Prohibited attachment type (was 0xdeadbeef)
From: Ray Lee <ray-lk@madrabbit.org>
To: tomstdenis@yahoo.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: http://madrabbit.org/
Message-Id: <1089215855.4373.194.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 07 Jul 2004 08:57:36 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 07, 2004 at 04:48:36AM -0700, tom st denis wrote:
> It will warn that 0xDEADBEEF is unsigned (which it isn't).

It is. Either read the standard, or read any of my email messages where
I quote the thing at you.

> Either there is an obscure clause in the C standard

Duuuude. The ANSI C standard is about 40 pages in the back of the K&R
second edition. You could read through it in a few hours. If you're
writing C code for more than just a pastime, you should do yourself a 
favor and read it. It's really not all that obscure or hard to
understand.

> [I personally don't have a copy of C99 nor do I plan on reading it
> for this]

Then how about you listen to people who have it, read it, and understand
it? Or how about at least believing that gcc is telling you the truth
when it warns that 0xdeadbeef is an unsigned constant?

Ray


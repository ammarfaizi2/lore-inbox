Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbUK2U2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbUK2U2C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261784AbUK2U2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:28:01 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:14094 "EHLO
	smtp-vbr2.xs4all.nl") by vger.kernel.org with ESMTP id S261783AbUK2U1k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:27:40 -0500
Date: Mon, 29 Nov 2004 21:27:35 +0100
From: Jurriaan <thunder7@xs4all.nl>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] why does radeonfb work fine in 2.6, but not in 2.4.29-pre1?
Message-ID: <20041129202735.GA20940@middle.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20041128184606.GA2537@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041128184606.GA2537@middle.of.nowhere>
X-Message-Flag: Still using Outlook? As you can see, it has some errors.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jurriaan <thunder7@xs4all.nl>
Date: Sun, Nov 28, 2004 at 07:46:06PM +0100
> The same radeonfb-setup works fine in every 2.6 kernel I can remember
> (last tested with 2.6.10-rc2-mm3) but give the dreaded 'cannot map FB'
> in 2.4.29-pre1.
> 
> The card has 128 Mb of ram, and my system has 3 Mb of RAM.

I mean 3 Gb, of course. Sorry about that. This means I got high memory.

I'd love to know what difference 2.4 and 2.6 have in this regard.

Jurriaan
-- 
The memory management on the PowerPC can be used to frighten small children.
	Linus Torvalds
Debian (Unstable) GNU/Linux 2.6.10-rc2-mm3 2x6078 bogomips load load 0.31

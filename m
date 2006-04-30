Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWD3GsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWD3GsP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Apr 2006 02:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750991AbWD3GsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Apr 2006 02:48:15 -0400
Received: from bigben2.bytemark.co.uk ([80.68.81.132]:42983 "EHLO
	bigben2.bytemark.co.uk") by vger.kernel.org with ESMTP
	id S1750989AbWD3GsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Apr 2006 02:48:14 -0400
Subject: Re: World writable tarballs
From: Matthew Reppert <arashi@sacredchao.net>
To: Joshua Hudson <joshudson@gmail.com>
In-Reply-To: <bda6d13a0604292159r3187b76fg56b137816480bf2a@mail.gmail.com>
References: <1146356286.10953.7.camel@hammer>
	 <200604300148.12462.s0348365@sms.ed.ac.uk>
	 <bda6d13a0604292159r3187b76fg56b137816480bf2a@mail.gmail.com>
Content-Type: text/plain
Organization: Yomerashi
Date: Sun, 30 Apr 2006 02:47:55 -0400
Message-Id: <1146379675.8217.2.camel@minerva>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-29 at 21:59 -0700, Joshua Hudson wrote:
>
> This REALLY needs fixing. If it weren't so late right now I might have written
> a filter that takes a tarball and sanitizes the permissions. I've got
> good reasons
> for compiling the kernel as root (when in the make, install, reboot, test loop
> it's quite a timesaver).

Isn't it just an extra ten seconds to type the 'sudo' in front of 'make
modules_install' and enter your password?  I guess I totally don't get
it.

Matt


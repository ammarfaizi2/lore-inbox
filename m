Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTJTQos (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJTQos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:44:48 -0400
Received: from fiberbit.xs4all.nl ([213.84.224.214]:42398 "EHLO
	fiberbit.xs4all.nl") by vger.kernel.org with ESMTP id S262652AbTJTQor
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:44:47 -0400
Date: Mon, 20 Oct 2003 18:43:49 +0200
From: Marco Roeland <marco.roeland@xs4all.nl>
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: RH7.3 can't compile 2.6.0-test8
Message-ID: <20031020164349.GA12986@localhost>
References: <0c1101c396f4$00bfeaf0$24ee4ca5@DIAMONDLX60> <3F93EABF.5000805@g-house.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <3F93EABF.5000805@g-house.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday October 20th 2003 at 16:01 Christian Kujau wrote:

> Norman Diamond schrieb:
> [...]
> > [ndiamond@c1pc40 linux-2.6.0-test8]$ gcc -v
> > Reading specs from /usr/lib/gcc-lib/i386-redhat-linux/2.96/specs
> > gcc version 2.96 20000731 (Red Hat Linux 7.3 2.96-110)
> > [ndiamond@c1pc40 linux-2.6.0-test8]$ rpm -qa binutils
> > binutils-2.11.93.0.2-11
> 
> did you try with a gcc 3.x too? perhaps it's (only) a compiler issue...

No, you just need to upgrade binutils to version 2.12 or higher, as mentioned
in Documentation/Changes. The gcc version is fine.
-- 
Marco Roeland

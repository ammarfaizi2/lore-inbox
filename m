Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290807AbSAaBU6>; Wed, 30 Jan 2002 20:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290806AbSAaBUw>; Wed, 30 Jan 2002 20:20:52 -0500
Received: from zero.tech9.net ([209.61.188.187]:65028 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290805AbSAaBT5>;
	Wed, 30 Jan 2002 20:19:57 -0500
Subject: Re: Kernel -- GCC Version
From: Robert Love <rml@tech9.net>
To: Ro0tSiEgE <ro0tsiege@bjstuff.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <055301c1a9f3$af5f73e0$ed00000a@citrix.bjstuff.com>
In-Reply-To: <055301c1a9f3$af5f73e0$ed00000a@citrix.bjstuff.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 30 Jan 2002 20:25:56 -0500
Message-Id: <1012440357.3392.95.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-01-30 at 20:07, Ro0tSiEgE wrote:
> I've looked on kernel.org, in the kernel sources, it its not really clear,
> from what I would see. If someone could tell me exactly what are the best
> and/or what Linus uses versions of gcc, etc. for compiling the different
> kernels? (2.0/2.2/2.4/2.5) Thanks!

For the kernel you are interested in, look in Documentation/Changes

All the requirements are listed.

For current 2.4 kernels, 2.95.x is the minimum.  2.96 works great.

	Robert Love


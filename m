Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281763AbRKZPXC>; Mon, 26 Nov 2001 10:23:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281772AbRKZPWw>; Mon, 26 Nov 2001 10:22:52 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:4742 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S281763AbRKZPWn>; Mon, 26 Nov 2001 10:22:43 -0500
Date: Mon, 26 Nov 2001 08:22:44 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: war <war@starband.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PPC Question
Message-ID: <20011126082244.D1132@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3C0259B4.86124AE1@starband.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C0259B4.86124AE1@starband.net>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 10:03:16AM -0500, war wrote:

> I don't mind trying to compile release kernels on a PPC box, however
> when I send a bug report to LKML, everyone shoots it down and tells me
> to use someone else's source tree.

...just like every other arch, except x86.

> If people do not care about PPC in the kernel, should it be included in
> the source, or should I just forget about trying to use the 'stock'
> kernel and use someone else's PPC source tree (which are usually a few
> versions behind) in order to compile the kernel?

No, you should use the PPC community trees which all of the PPC
maintainers use and is at worst a day behind kernel.org (But usually
just a few hours...).

http://penguinppc.org/dev/kernel.shtml

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289015AbSAZDpS>; Fri, 25 Jan 2002 22:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289012AbSAZDpH>; Fri, 25 Jan 2002 22:45:07 -0500
Received: from pc-62-31-92-140-az.blueyonder.co.uk ([62.31.92.140]:41602 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S289011AbSAZDo4>; Fri, 25 Jan 2002 22:44:56 -0500
Date: Sat, 26 Jan 2002 03:41:06 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ACPI] ACPI mentioned on lwn.net/kernel
Message-ID: <20020126034106.F5730@kushida.apsleyroad.org>
In-Reply-To: <200201251550.g0PFoIPa002738@tigger.cs.uni-dortmund.de> <200201250802.32508.bodnar42@phalynx.dhs.org> <jeelkes8y5.fsf@sykes.suse.de> <a2sv2s$ge3$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <a2sv2s$ge3$1@penguin.transmeta.com>; from torvalds@transmeta.com on Sat, Jan 26, 2002 at 01:00:12AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> It's sad that gcc relegates "optimize for size" to a second-class
> citizen.  Instead of having a "-Os" (that optimizes for size and doesn't
> work together with other optimizations), it would be better to have a
> "-Olargecode", which explicitly enables "don't care about code size" for
> those (few) applications where it makes sense.

Btw, there have been suggestions that -Os may actually be faster for x86
code on current processors.

-- Jamie

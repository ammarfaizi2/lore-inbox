Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130267AbQLBUjl>; Sat, 2 Dec 2000 15:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbQLBUjb>; Sat, 2 Dec 2000 15:39:31 -0500
Received: from vitelus.com ([64.81.36.147]:36619 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S130267AbQLBUjP>;
	Sat, 2 Dec 2000 15:39:15 -0500
Date: Sat, 2 Dec 2000 12:08:46 -0800
From: Aaron Lehmann <aaronl@vitelus.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transmeta and Linux-2.4.0-test12-pre3
Message-ID: <20001202120846.C16734@vitelus.com>
In-Reply-To: <200012020409.UAA04058@adam.yggdrasil.com> <90a065$5ai$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <90a065$5ai$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 01, 2000 at 09:09:25PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2000 at 09:09:25PM -0800, Linus Torvalds wrote:
> NOTE! Getting the 2.4.x kernel up and running is the easy part.  The
> machine also has a very recent ATI Rage Mobility chip in it, and you
> need the newest XFree86 CVS snapshot to make it work (along with a
> one-liner patch from me, unless that has already made it into the CVS
> tree by now).

It seems to just have:

  1067. Fix ATI clock generator recognition when an adapter BIOS
  cannot be retrieved (Linus Torvals).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

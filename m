Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263575AbREYGba>; Fri, 25 May 2001 02:31:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263579AbREYGbU>; Fri, 25 May 2001 02:31:20 -0400
Received: from vitelus.com ([64.81.36.147]:28939 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S263575AbREYGbN>;
	Fri, 25 May 2001 02:31:13 -0400
Date: Thu, 24 May 2001 23:31:11 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Matthew Jacob <mjacob@feral.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Copyright infringement in linux/drivers/usb/serial/keyspan*fw.h
Message-ID: <20010524233111.F23155@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.BSF.4.21.0105242325460.4980-100000@beppo.feral.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 11:26:20PM -0700, Matthew Jacob wrote:
> Sure- that's not BSD. You were speaking about all kinds of firmware, at least
> I thought you were. Must be too short on sleep.

Yes, I am. New-style BSD licenses are compatible with the GPL. As long
as a piece of firmware contains source (which I discussed in a
previous post; see the GPL for the relevent defenition of source code)
and is under a GPL-compatible license it should be fine (excepting
further issues like patents.

In the case of the keyspan drivers, the source code is not distributed
and the license is not free, nor GPL-compatible. I hear steps are
going towards resolving this, which is excellent. My other concern is
what the general policy towards these non-free firmware images
is/should be. I know that a lot of firmware exists in advansys.c, and
there are probably many more occurances of binary-only firmware
throughout the kernel.

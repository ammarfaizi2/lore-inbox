Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131475AbQJ2A2I>; Sat, 28 Oct 2000 20:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131471AbQJ2A16>; Sat, 28 Oct 2000 20:27:58 -0400
Received: from piglet.twiddle.net ([207.104.6.26]:15113 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S131462AbQJ2A1l>; Sat, 28 Oct 2000 20:27:41 -0400
Date: Sat, 28 Oct 2000 17:27:00 -0700
From: Richard Henderson <rth@twiddle.net>
To: Keith Owens <kaos@ocs.com.au>, Pavel Machek <pavel@suse.cz>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001028172700.A13608@twiddle.net>
In-Reply-To: <20001027194513.A1060@bug.ucw.cz> <4309.972694843@ocs3.ocs-net> <20001028131558.A17429@uni-mainz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001028131558.A17429@uni-mainz.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 01:15:58PM +0200, Dominik Kubla wrote:
> Even simpler: "gcc -V 2.7.2.3" or "gcc -V 2.95.2" or whatever...

Which was a nice idea, but it doesn't actually work.  Changes
in spec file format between versions makes this fall over.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

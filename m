Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129042AbQJ3SvU>; Mon, 30 Oct 2000 13:51:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129112AbQJ3SvK>; Mon, 30 Oct 2000 13:51:10 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:59915 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S129042AbQJ3SvA>; Mon, 30 Oct 2000 13:51:00 -0500
Date: Mon, 30 Oct 2000 10:50:54 -0800
From: Richard Henderson <rth@twiddle.net>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Keith Owens <kaos@ocs.com.au>, Pavel Machek <pavel@suse.cz>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001030105054.A15381@twiddle.net>
In-Reply-To: <20001027194513.A1060@bug.ucw.cz> <4309.972694843@ocs3.ocs-net> <20001028131558.A17429@uni-mainz.de> <20001028172700.A13608@twiddle.net> <20001029160916.B12250@uni-mainz.de> <20001030050543.A9175@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <20001030050543.A9175@wire.cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30, 2000 at 05:05:43AM -0600, Peter Samuelson wrote:
> But I think it's since been fixed:

No.

> Is there more subtle breakage?

Yes.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129325AbQLRPUi>; Mon, 18 Dec 2000 10:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129631AbQLRPU2>; Mon, 18 Dec 2000 10:20:28 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:30546 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S129325AbQLRPUR>; Mon, 18 Dec 2000 10:20:17 -0500
Date: Mon, 18 Dec 2000 15:49:07 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Daiki Matsuda <dyky@df-usa.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
Message-ID: <20001218154907.A16749@athlon.random>
In-Reply-To: <20001217153444N.dyky@df-usa.com> <20001218033154.F3199@cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20001218033154.F3199@cadcamlab.org>; from peter@cadcamlab.org on Mon, Dec 18, 2000 at 03:31:54AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 03:31:54AM -0600, Peter Samuelson wrote:
> directly.  You are changing perfectly legal C.

You're right that's not kernel issue and patch can be rejected, but he's not
really changing anything :). If changing that helps then it's a compiler bug.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

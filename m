Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131227AbQLRPp0>; Mon, 18 Dec 2000 10:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLRPpQ>; Mon, 18 Dec 2000 10:45:16 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:58712 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S131227AbQLRPpF>; Mon, 18 Dec 2000 10:45:05 -0500
Date: Mon, 18 Dec 2000 16:14:28 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Daiki Matsuda <dyky@df-usa.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
Message-ID: <20001218161428.D16749@athlon.random>
In-Reply-To: <20001217153444N.dyky@df-usa.com> <20001218033154.F3199@cadcamlab.org> <20001218154907.A16749@athlon.random> <14910.10020.692884.302587@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14910.10020.692884.302587@wire.cadcamlab.org>; from peter@cadcamlab.org on Mon, Dec 18, 2000 at 09:03:00AM -0600
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2000 at 09:03:00AM -0600, Peter Samuelson wrote:
> Not a compiler bug, a source bug of assuming a C header file can be
> included by a C++ program. [..]

C++ obviously doesn't care about the name of parameters in a function too.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130770AbQLRPzR>; Mon, 18 Dec 2000 10:55:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130750AbQLRPzI>; Mon, 18 Dec 2000 10:55:08 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:52228 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130770AbQLRPy5>; Mon, 18 Dec 2000 10:54:57 -0500
Date: Mon, 18 Dec 2000 09:24:17 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Daiki Matsuda <dyky@df-usa.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18 asm-alpha/system.h has a problem
Message-ID: <20001218092416.I3199@cadcamlab.org>
In-Reply-To: <20001217153444N.dyky@df-usa.com> <20001218033154.F3199@cadcamlab.org> <20001218154907.A16749@athlon.random> <14910.10020.692884.302587@wire.cadcamlab.org> <20001218161428.D16749@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001218161428.D16749@athlon.random>; from andrea@suse.de on Mon, Dec 18, 2000 at 04:14:28PM +0100
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Andrea Arcangeli]
> C++ obviously doesn't care about the name of parameters in a function
> too.

Sure it does when they are language keywords.  In this case he is
trying to change the parameter name "new".

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

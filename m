Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129693AbRBVDNr>; Wed, 21 Feb 2001 22:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129782AbRBVDNh>; Wed, 21 Feb 2001 22:13:37 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:31757 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129693AbRBVDNd>; Wed, 21 Feb 2001 22:13:33 -0500
Date: Wed, 21 Feb 2001 21:13:30 -0600
To: John Heil <kerndev@sc-software.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.2
Message-ID: <20010221211330.A21010@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.10.10102211811430.1005-100000@penguin.transmeta.com> <Pine.LNX.3.95.1010221182554.14140C-100000@scsoftware.sc-software.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.3.95.1010221182554.14140C-100000@scsoftware.sc-software.com>; from kerndev@sc-software.com on Wed, Feb 21, 2001 at 06:31:18PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[John Heil]
> Which -ac series patch does this match up with or superceed ie should
> this be considered superior to -ac19 ?

Neither "supercedes" the other -- they are different trees.  The -ac
series has some patches that Linus may never get because they are
experimental, or still buggy.

If you want stability, run the real Linus 2.4.  If you want all the
really minor bug fixes and more of the experimental code, run -ac.  If
you want production quality, run your kernel on a test server before
deploying.  (As always!)

Peter

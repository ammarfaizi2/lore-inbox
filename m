Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282482AbRLWRIs>; Sun, 23 Dec 2001 12:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282413AbRLWRIj>; Sun, 23 Dec 2001 12:08:39 -0500
Received: from Sophia.Soo.com ([199.202.113.33]:47876 "EHLO Soo.com")
	by vger.kernel.org with ESMTP id <S282482AbRLWRI1>;
	Sun, 23 Dec 2001 12:08:27 -0500
Date: Sun, 23 Dec 2001 12:08:25 -0500
From: really mason_at_soo_dot_com <lnx-kern@Sophia.soo.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.2-pre1 oddness under X
Message-ID: <20011223120825.A22239@Sophia.soo.com>
In-Reply-To: <20011222164602.A20623@Sophia.soo.com> <3C250835.9010806@wanadoo.fr> <20011223151147.F7438@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011223151147.F7438@suse.de>; from axboe@suse.de on Sun, Dec 23, 2001 at 03:11:47PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yikes, hope not.  But yeps, i'm using IDE drives,
ATA100 master and ATA66 slave.  It's a VIA vt8233
south bridge.  i also have the FSB overclocked so
the PCI bus is running at 37mhz.  That's caused
no trouble so far.

b

On Sun, Dec 23, 2001 at 03:11:47PM +0100, Jens Axboe wrote:
> This sounds like disk corruption, it may be that the -pre1 changes are
> partially broken.
> 
> I'll go take a look. IDE?

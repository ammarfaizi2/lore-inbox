Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129632AbQKESFe>; Sun, 5 Nov 2000 13:05:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129696AbQKESFY>; Sun, 5 Nov 2000 13:05:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51473 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129632AbQKESFM>;
	Sun, 5 Nov 2000 13:05:12 -0500
Date: Sun, 5 Nov 2000 18:05:07 +0000
From: Philipp Rumpf <prumpf@parcelfarce.linux.theplanet.co.uk>
To: "Heusden, Folkert van" <f.v.heusden@ftr.nl>
Cc: "'Linux Kernel Development'" <linux-kernel@vger.kernel.org>
Subject: Re: i82808 hardware hub RNG
Message-ID: <20001105180507.Z2272@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <27525795B28BD311B28D00500481B7601623D5@ftrs1.intranet.FTR.NL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <27525795B28BD311B28D00500481B7601623D5@ftrs1.intranet.FTR.NL>; from f.v.heusden@ftr.nl on Sun, Nov 05, 2000 at 06:19:21PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 05, 2000 at 06:19:21PM +0100, Heusden, Folkert van wrote:
> I wrote a daemon that fetches (as root-user) random numbers from the RNG in
> the i82808 (found on 815-chipsets).
> You can download it from http://www.vanheusden.com/Linux/random.php3 .
> Currently, I'm trying to rewrite things into a kernel-module so that one has
> a standard character device which can deliver random values then.
> Please give it a try as I do not own a PC with such a motherboard ;-/

So how is this different from drivers/char/i810_rng.c ?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/

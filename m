Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137106AbRAHMmf>; Mon, 8 Jan 2001 07:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137122AbRAHMmZ>; Mon, 8 Jan 2001 07:42:25 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:8197 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S137106AbRAHMmR>; Mon, 8 Jan 2001 07:42:17 -0500
Date: Mon, 8 Jan 2001 06:41:57 -0600
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Announce: modutils 2.4.0 is available
Message-ID: <20010108064157.A3385@cadcamlab.org>
In-Reply-To: <Pine.LNX.4.21.0101052200380.2574-100000@bee.lk> <200101051933.f05JXAT17275@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101051933.f05JXAT17275@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Fri, Jan 05, 2001 at 07:33:10PM +0000
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Russell King]
> Can't you get the source, and whatever relevent files you need to
> build a dpkg and build the source + binary packages yourself (with
> maybe a few minor changes to the dpkg build information)?

Right.  No changes at all.  modutils_2.3.23-2.diff.gz applies fine,
except for one bit that already made it upstream -- ignore the .rej .

Peter

(woody build, if anyone cares...
  http://wire.cadcamlab.org/misc/modutils_2.4.0-0woody0.1_i386.deb
)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
